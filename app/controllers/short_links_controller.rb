# Redirección pública de los enlaces cortos: globalmedia.mx/Ab3xK9 → nota.
class ShortLinksController < ApplicationController
  def show
    link = ShortLink.find_by(code: params[:code])
    return redirect_to(root_path) unless link

    link.register_click!
    # 302 para que cada visita llegue al servidor y se cuente el clic.
    redirect_to link.url, allow_other_host: true, status: :found
  end
end
