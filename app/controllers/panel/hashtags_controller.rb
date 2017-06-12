class Panel::HashtagsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_news_chief

	autocomplete :hashtag, :name, full: true
	
	def index
		@hashtags = Hashtag.order(selected: "DESC", updated_at: "DESC").paginate(page: params[:page], per_page: 200)
	end
	def selecting_hashtags
		@hashtags = Hashtag.where(selected: true).order(updated_at: "DESC").last(4)
	end
	def switch_hashtag 
		hashtag = Hashtag.find(params[:id])

		if hashtag.selected
			hashtag.update_attributes(selected: false)
		else
			if Hashtag.where(selected: true).count > 3
				oldest_hashtag = Hashtag.where(selected: true).order(selected_on: "DESC").last
				oldest_hashtag.update_attributes(selected: false)
			end

			hashtag.update_attributes(selected: true, selected_on: Time.now)
		end
		render json: { hashtag: hashtag }, status: :ok
	end
	def set_selected
		Hashtag.all.update_all(selected: false)

		h_1 = Hashtag.find_by(name: params[:panel][:h_1])
		h_2 = Hashtag.find_by(name: params[:panel][:h_2])
		h_3 = Hashtag.find_by(name: params[:panel][:h_3])
		h_4 = Hashtag.find_by(name: params[:panel][:h_4])
		
		h_1.update_attributes(selected: true, selected_on: Time.now)
		h_2.update_attributes(selected: true, selected_on: Time.now)
		h_3.update_attributes(selected: true, selected_on: Time.now)
		h_4.update_attributes(selected: true, selected_on: Time.now)

		redirect_to panel_hashtags_path
	end
	

	
end
