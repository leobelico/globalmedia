require "securerandom"

# Enlaces cortos de notas: globalmedia.mx/Ab3xK9 → la nota completa.
# Solo se aceptan enlaces de notas de Global Media (dominio principal o subdominios regionales).
class ShortLink < ApplicationRecord
  CODE_LENGTH = 6
  CODE_CHARS = [*"a".."z", *"A".."Z", *"0".."9"].freeze
  CODE_FORMAT = /\A[a-zA-Z0-9]{#{CODE_LENGTH}}\z/
  ALLOWED_HOST = /\A([a-z0-9-]+\.)?globalmedia\.(mx|onrender\.com)\z/i

  belongs_to :article, optional: true
  belongs_to :user, optional: true

  validates :code, presence: true, uniqueness: { case_sensitive: true }, format: { with: CODE_FORMAT }
  validates :url, presence: true

  before_validation :assign_code, on: :create

  scope :recent, -> { order(created_at: :desc) }

  # Dominio de los enlaces cortos (configurable con SHORT_LINK_HOST).
  def self.host
    ENV.fetch("SHORT_LINK_HOST", "globalmedia.mx")
  end

  def short_url
    "https://#{self.class.host}/#{code}"
  end

  def display_url
    "#{self.class.host}/#{code}"
  end

  # Destino final sin saltos extra: el dominio sin "www" redirige a "www", así que se usa "www" de una vez.
  def target_url
    url.sub(%r{\Ahttps?://globalmedia\.mx/}i, "https://www.globalmedia.mx/")
  end

  MAX_URL_LENGTH = 2000

  # Crea (o reutiliza) un enlace corto para cualquier URL http(s).
  # Si es una nota de Global Media se liga a la nota (para la vista previa en WhatsApp/Facebook).
  # Devuelve el ShortLink o lanza ArgumentError con un mensaje para el editor.
  def self.for_input(input, user: nil)
    input = input.to_s.strip
    raise ArgumentError, "Pega el enlace que quieres acortar" if input.blank?

    article, url = resolve_article(input)
    article, url = nil, normalize_external(input) unless article

    existing = (article && find_by(article_id: article.id)) || find_by(url: url)
    return existing if existing

    create!(url: url, article: article, user: user)
  end

  # Nota de Global Media a partir de "https://www.globalmedia.mx/articles/mi-nota",
  # "zacatecas.globalmedia.mx/articles/mi-nota" o solo el slug "mi-nota". Devuelve nil si no es una nota.
  def self.resolve_article(input)
    slug =
      if input.include?("/")
        uri = parse_uri(input)
        return nil unless uri&.host&.match?(ALLOWED_HOST)

        match = uri.path.to_s.match(%r{\A/articles/([^/?#]+)/?\z})
        return nil unless match

        CGI.unescape(match[1])
      else
        input
      end

    article = Article.find_by(slug: slug)
    return nil unless article

    base = input.include?("/") ? parse_uri(input) : nil
    host = base&.host.presence || "www.globalmedia.mx"
    host = "www.globalmedia.mx" if host.casecmp?("globalmedia.mx")
    [article, "https://#{host}/articles/#{CGI.escape(article.slug).gsub('+', '%20')}"]
  end

  # Valida y normaliza un enlace externo (cualquier sitio http/https).
  def self.normalize_external(input)
    raise ArgumentError, "El enlace es demasiado largo (máximo #{MAX_URL_LENGTH} caracteres)" if input.length > MAX_URL_LENGTH
    raise ArgumentError, "El enlace no puede tener espacios" if input.match?(/\s/)

    uri = parse_uri(input)
    unless uri.is_a?(URI::HTTP) && uri.host.present? && uri.host.include?(".")
      raise ArgumentError, "Ese texto no parece un enlace válido (ejemplo: https://sitio.com/pagina)"
    end
    # Evita acortar un enlace corto (redirección en círculo).
    if uri.host.match?(ALLOWED_HOST)
      code = uri.path.to_s.delete_prefix("/").delete_suffix("/")
      raise ArgumentError, "Ese ya es un enlace corto de Global Media" if code.match?(CODE_FORMAT) && exists?(code: code)
    end

    uri.to_s
  end

  def self.parse_uri(input)
    str = input.match?(%r{\Ahttps?://}i) ? input : "https://#{input}"
    begin
      URI.parse(str)
    rescue URI::InvalidURIError
      # Enlaces con acentos u otros caracteres especiales: se codifican y se vuelve a intentar.
      URI.parse(URI::DEFAULT_PARSER.escape(str))
    end
  rescue URI::InvalidURIError
    nil
  end

  def register_click!
    self.class.where(id: id).update_all(["clicks = clicks + 1, last_clicked_at = ?", Time.current])
  end

  private

  # Código aleatorio de 6 letras/números que no exista ni choque con el nombre de una estación (/:id).
  def assign_code
    return if code.present?

    20.times do
      candidate = Array.new(CODE_LENGTH) { CODE_CHARS[SecureRandom.random_number(CODE_CHARS.size)] }.join
      next if self.class.exists?(code: candidate)
      next if Station.where("LOWER(slug) = ?", candidate.downcase).exists?

      self.code = candidate
      return
    end
    errors.add(:code, "no se pudo generar, intenta de nuevo")
  end
end
