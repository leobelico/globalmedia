
class Panel::NotificationsController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource


	def index
		@notifications = Notification.all
	end

	def new
		@notification = Notification.new	
	end

	def create
		# AWS = Aws::Credentials.new('AKIAIIK57E6XREQWWYQQ', 'CP1BwWcZB+DPqiuZK8K6z3J2Z4KUDRMy/f/VcBQR')
		@notification = Notification.new(notification_params)
		if @notification.save
			SendNotificationsJob.perform_later @notification
			redirect_to panel_notifications_path
		else
			render action: "new"
		end
	end

	

	private
		def notification_params
			params.require(:notification).permit(:title, :body)
		end

		def set_notification
			@notification = Notification.find(params[:id])
		end
		

end
