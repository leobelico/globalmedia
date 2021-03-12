class SitemapController < ApplicationController

  def index
    host = 'https://www.globalmedia.mx'
    sitemap = params[:sitemap]
    @items = []
    if sitemap == 'articles' || sitemap == nil
      elements = SitemapIndex.order(lastmod: 'DESC')
      elements.each do |element|
        @items.push(
          {
            'loc' => "#{host}/sitemap/#{element.id}/articles.xml",
            'lastmod' => element.lastmod.to_date
          }
        )
      end
    end
    respond_to do |format|
      format.xml { render :template => 'sitemap/index'}
    end
  end

  def sitemap
    sitemap_id = Integer(params[:id])
    sitemap = params[:sitemap]
    @items = []
    if sitemap == 'articles'
      @items = SitemapIndexedArticle.where('sitemap_index_id = ?', sitemap_id).order(lastmod: 'DESC')
    end
    respond_to do |format|
      format.xml { render :template => 'sitemap/sitemap'}
    end
  end

  def google_news
    now = DateTime.now
    two_days = (now.to_time - 48.hours).to_datetime
    @items = Article.where('published_at >= ?', two_days).order('published_at DESC')
    respond_to do |format|
      format.xml { render :template => 'sitemap/sitemap_google_news'}
    end
  end
end
