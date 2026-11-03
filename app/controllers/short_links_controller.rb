# Redirección pública de los enlaces cortos: globalmedia.mx/Ab3xK9 → nota.
class ShortLinksController < ApplicationController
  # Robots que generan la vista previa al pegar un enlace (WhatsApp, Facebook, X, Telegram, etc.).
  PREVIEW_BOTS = /facebookexternalhit|facebot|whatsapp|twitterbot|telegrambot|slackbot|linkedinbot|discordbot|pinterest|skypeuripreview|redditbot|applebot|vkshare|embedly|quora link preview|google-inspectiontool/i

  def show
    link = ShortLink.find_by(code: params[:code])
    return redirect_to(root_path) unless link

    if link.article && request.user_agent.to_s.match?(PREVIEW_BOTS)
      # Sin redirecciones: el robot recibe aquí mismo el título, descripción e imagen de la nota.
      @article = link.article
      @target_url = link.target_url
      return render :preview, layout: false
    end

    link.register_click!
    # 302 para que cada visita llegue al servidor y se cuente el clic.
    redirect_to link.target_url, allow_other_host: true, status: :found
  end
end
