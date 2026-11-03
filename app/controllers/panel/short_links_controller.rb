class Panel::ShortLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_articles_permission

  RECENT_LIMIT = 5
  SEARCH_LIMIT = 20

  # Por defecto solo los 5 más recientes (la lista crece mucho); con búsqueda, hasta 20 coincidencias.
  def index
    @short_link = ShortLink.find_by(id: params[:created]) if params[:created]
    @searching = params[:q].present?
    @short_links = ShortLink.includes(:article, :user).recent
    if @searching
      term = "%#{params[:q].strip}%"
      @short_links = @short_links.left_joins(:article)
                                 .where("articles.name ILIKE :t OR short_links.code = :c OR short_links.url ILIKE :t", t: term, c: params[:q].strip)
                                 .limit(SEARCH_LIMIT)
    else
      @short_links = @short_links.limit(RECENT_LIMIT)
    end
  end

  def create
    link = ShortLink.for_input(params[:url], user: current_user)
    redirect_to panel_short_links_path(created: link.id)
  rescue ArgumentError, ActiveRecord::RecordInvalid => e
    redirect_to panel_short_links_path(url: params[:url]), alert: e.message
  end

  def destroy
    ShortLink.find(params[:id]).destroy
    redirect_to panel_short_links_path, notice: "Enlace corto eliminado"
  end

  private

  def require_articles_permission
    return if current_user.create_articles_permission? || current_user.destroy_articles_permission?

    redirect_to panel_path, alert: "No tienes permiso para acortar enlaces"
  end
end
