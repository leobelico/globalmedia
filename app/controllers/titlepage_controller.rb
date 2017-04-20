class TitlepageController < ApplicationController
	def index
		@highlights = Highlight.all.order(order: "ASC")
		search = Hashtag.find_by_name("#ESNOTICIA")
		@its_news = ArticlesHashtag.where(hashtag_id: search).last(10)
		#@sections = Section.articles.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articable_id").where('highlights.article_id IS NULL')
		@sections = Section.where('name != ?', "Último Momento")
		



	end

end
