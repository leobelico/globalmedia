class Panel::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_user_permission
	before_action :set_user, only: [:show, :edit, :update]
	
	def index
		@users = User.all.order(created_at: "DESC").paginate(page: params[:page], per_page: 20)
	end
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		pass = SecureRandom.uuid
		@user.password =  pass
  		@user.password_confirmation = pass
  		raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
		@user.reset_password_token = hashed_token
		@user.reset_password_sent_at = Time.now.utc
		if @user.save
			UserMailer.confirmation_email(@user, raw_token).deliver_now
			#NOTAS DEL PROGRAMADOR: 
			#CAMBIAR ESTE REDIRECT AL DEL PANEL
			redirect_to panel_users_path
		else
			render action: "new"	
		end

	end
	def show
		
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to panel_users_path
		else
			render action: "edit"	
		end
	end

	def destroy
	end

	

	private
		
		def authenticate_user_permission
			if !current_user.user_permission?
				redirect_to panel_path
			end
		end
		def set_user
			@user = User.find(params[:id])
			rescue  ActiveRecord::RecordNotFound
				flash[:alert] = "404, we didn't the information you are looking for."
				redirect_to root_url
		end
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :role, :create_articles_permission, :destroy_articles_permission, :video_complaints_permission, :radio_stations_permission, :remote_controls_permission, :banners_permission, :hits_permission, :user_permission   )
		end
end
