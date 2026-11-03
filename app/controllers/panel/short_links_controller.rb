class Panel::ShortLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_articles_permission

  def index
    @short_link = ShortLink.find_by(id: params[:created]) if params[:created]
    @short_links = ShortLink.includes(:article).recent
    if params[:q].present?
      term = "%#{params[:q].strip}%"
      @short_links = @short_links.left_joins(:article).where("articles.name ILIKE :t OR short_links.code = :c OR short_links.url ILIKE :t", t: term, c: params[:q].strip)
    end
    @short_links = @short_links.paginate(page: params[:page], per_page: 20)
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

  # TEMPORAL: muestra el error real (solo a usuarios con sesión en el panel) para diagnosticar el 500.
  rescue_from StandardError do |e|
    raise e unless user_signed_in?

    Rails.logger.error("[short_links] #{e.class}: #{e.message}\n#{e.backtrace.first(15).join("\n")}")
    app_lines = e.backtrace.select { |l| l.include?("/app/") }.first(8)
    render plain: "Error en el acortador (diagnóstico temporal)\n\n#{e.class}: #{e.message}\n\n#{app_lines.join("\n")}\n\n#{e.backtrace.first(5).join("\n")}",
           status: :internal_server_error
  end

  private

  def require_articles_permission
    return if current_user.create_articles_permission? || current_user.destroy_articles_permission?

    redirect_to panel_path, alert: "No tienes permiso para acortar enlaces"
  end
end
