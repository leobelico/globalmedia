require "net/http"

# Entrega la imagen de una nota con el tipo correcto (image/jpeg, image/png…) para las vistas previas
# de WhatsApp y Facebook. Las fotos subidas desde el panel quedaron en S3 como "binary/octet-stream",
# y WhatsApp descarta imágenes que no se identifican como imagen.
class SocialImagesController < ApplicationController
  # Solo se sirven imágenes del bucket de Global Media (no es un proxy abierto).
  ALLOWED_HOSTS = /\Aglobalmediarocks\.s3[.-]([a-z0-9-]+\.)?amazonaws\.com\z/i
  ALLOWED_HOSTS_IN_URL = %r{\Ahttps://globalmediarocks\.s3[.-]([a-z0-9-]+\.)?amazonaws\.com/}i
  MAX_BYTES = 8 * 1024 * 1024

  def show
    article = Article.find_by(id: params[:id])
    return head(:not_found) unless article

    source = helpers.social_image_source(article)
    uri = URI.parse(source)
    return redirect_to(source, allow_other_host: true) unless uri.host.to_s.match?(ALLOWED_HOSTS)

    body = fetch(uri)
    type = image_type(body)
    return redirect_to(source, allow_other_host: true) unless type

    response.headers["Cache-Control"] = "public, max-age=604800"
    send_data body, type: type, disposition: "inline"
  rescue StandardError => e
    Rails.logger.warn("[og-image] #{params[:id]}: #{e.class} #{e.message}")
    source ? redirect_to(source, allow_other_host: true) : head(:not_found)
  end

  private

  def fetch(uri)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", open_timeout: 4, read_timeout: 8) do |http|
      res = http.get(uri.request_uri)
      raise "HTTP #{res.code}" unless res.is_a?(Net::HTTPSuccess)
      raise "imagen demasiado grande" if res.body.bytesize > MAX_BYTES

      res.body
    end
  end

  # Tipo real según los primeros bytes del archivo.
  def image_type(body)
    head = body.to_s.byteslice(0, 12).to_s.b
    return "image/jpeg" if head.start_with?("\xFF\xD8\xFF".b)
    return "image/png" if head.start_with?("\x89PNG".b)
    return "image/gif" if head.start_with?("GIF8".b)
    return "image/webp" if head.start_with?("RIFF".b) && head.byteslice(8, 4) == "WEBP".b

    nil
  end
end
