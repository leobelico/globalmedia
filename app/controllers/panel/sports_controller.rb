class Panel::SportsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_sport, only: [:show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]
	
	def index 
		@sports = Sport.all
	end
	def new
		@sport = Sport.new
	end
	def create
		@sport = Sport.new(sport_params)
		if @sport.save 
			redirect_to panel_sports_path
		else
			render action: "new"
		end
	end
	def edit 
	end
	def update
		if @sport.update(sport_params)
			redirect_to panel_sports_path
		else
			render action: "edit"
		end
	end
	def destroy
		@sport.destroy
		redirect_to panel_sports_path 
	end

	private
		def set_sport 
			@sport = Sport.find(params[:id])
		end
		def sport_params
			params.require(:sport).permit(:team_one, :team_two, :team_one_image, :team_two_image, :team_one_score, :team_two_score, :team_one_goal_scorers, :team_two_goal_scorers)
		end
		def set_s3_direct_post
			one_year_in_seconds = 365 * 24 * 60 * 60
			one_year_from_now = Time.now + one_year_in_seconds
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', expires: one_year_from_now, cache_control: "max-age=#{one_year_in_seconds}")
  		end
		
end
