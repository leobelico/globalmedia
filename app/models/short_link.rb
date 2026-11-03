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

  # Crea (o reutiliza) el enlace corto de una nota a partir de su URL o su slug.
  # Devuelve el ShortLink o lanza ArgumentError con un mensaje para el editor.
  def self.for_input(input, user: nil)
    article, url = resolve_article(input.to_s.strip)
    existing = find_by(article_id: article.id) || find_by(url: url)
    return existing if existing

    create!(url: url, article: article, user: user)
  end

  # Acepta "https://www.globalmedia.mx/articles/mi-nota", "zacatecas.globalmedia.mx/articles/mi-nota"
  # o solo el slug "mi-nota".
  def self.resolve_article(input)
    raise ArgumentError, "Pega el enlace de una nota" if input.blank?

    slug =
      if input.include?("/")
        uri = parse_uri(input)
        unless uri&.host&.match?(ALLOWED_HOST)
          raise ArgumentError, "Solo se pueden acortar enlaces de notas de globalmedia.mx"
        end
        match = uri.path.to_s.match(%r{\A/articles/([^/?#]+)/?\z})
        raise ArgumentError, "El enlace no es de una nota (debe verse como globalmedia.mx/articles/…)" unless match
        CGI.unescape(match[1])
      else
        input
      end

    article = Article.find_by(slug: slug)
    raise ArgumentError, "No encontramos ninguna nota con ese enlace" unless article

    base = input.include?("/") ? parse_uri(input) : nil
    host = base&.host.presence || "www.globalmedia.mx"
    [article, "https://#{host}/articles/#{CGI.escape(article.slug).gsub('+', '%20')}"]
  end

  def self.parse_uri(input)
    URI.parse(input.match?(%r{\Ahttps?://}i) ? input : "https://#{input}")
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
