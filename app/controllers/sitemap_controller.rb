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
            'lastmod' => element.lastmod
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
end
