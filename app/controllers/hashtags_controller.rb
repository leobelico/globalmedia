class HashtagsController < ApplicationController
	def remove
		@article =  Article.find(params[:article_id])
		@hashtag = Hashtag.find(params[:id])

		@article.hashtags.destroy(@hashtag)
		redirect_to :back
	end
end
