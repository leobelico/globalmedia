class ArticlesJob < ApplicationJob
  queue_as :default

  def perform()
    @articles = Article.where(published: true, created_at: (Date.today - 1.month).beginning_of_month..(Date.today).end_of_month).order(created_at: "ASC").last(8).reverse
    print "Calling serve"
    print @articles.first.name


    @articles.each do |article|
    	if article.section != "Quiénes somos" and  article.section != "Contáctanos" and article.section != "Anunciate con nosotros"
    		print "calling server"
    		print article.name
    		 # ActionCable.server.broadcast 'latest', article_name: article.name, section: article.section
    	end
    end

    print "Finish"
    return @articles
  end

  def latest_news

  end
end
