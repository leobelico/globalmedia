class Panel::AnalyticsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def export_articles
    from = params[:from]
    to = params[:to]
    now = DateTime.now.strftime("%Y-%m-%d_%H%M%S").to_s
    p = Axlsx::Package.new
    articles = Article.select('articles.*, sections.name AS section_name, authors.name AS author_name, SUM(hits.number) AS total_views')
                      .joins('INNER JOIN hits ON articles.id = hits.article_id')
                      .joins('INNER JOIN sections ON articles.articable_id = sections.id')
                      .joins('INNER JOIN authors ON articles.author_id = authors.id')
                      .where('articles.created_at BETWEEN ? AND ?', from, to)
                      .order('articles.created_at DESC')
                      .group('articles.id, section_name, author_name')
    p.workbook.add_worksheet(:name => "Articulos") do |sheet|
      sheet.add_row ["Id", "Titulo", "Estatus", "Fecha de programacion", "Seccion", "Escritor(Autor)", "Visitas", "Fecha de creacion"]
      articles.each do |article|
        status = article.published? ? 'Publicado' : article.draft == 0 ? 'Borrador' : article.draft == 1 ? 'Aprobado' : article.draft == 2 ? 'No aprobado' : ''
        sheet.add_row [article.id, article.name, status, article.published_at != nil ? article.published_at.to_datetime.strftime("%Y-%m-%d %H:%M:%S").to_s: '', article.section_name, article.author_name, article.total_views, article.created_at.to_datetime.strftime("%Y-%m-%d %H:%M:%S").to_s]
      end
    end
    p.use_shared_strings = true
    send_data p.to_stream.read, type: "application/xlsx", filename: "#{now}.xlsx"
  end
end
