class TitlepageController < ApplicationController
	def index
		search = Hashtag.find_by_name("#ESNOTICIA")
		@its_news = ArticlesHashtag.where(hashtag_id: search)
		@sections = Section.all
	end
end
