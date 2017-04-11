class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:show, :edit, :update]
	
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
			redirect_to current_user
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
			redirect_to @user
		else
			render action: "edit"	
		end
	end

	def destroy
	end

	

	private
		

		def set_user
			@user = User.find(params[:id])
			rescue  ActiveRecord::RecordNotFound
				flash[:alert] = "404, we didn't the information you are looking for."
				redirect_to root_url
		end
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :role)
		end
end
