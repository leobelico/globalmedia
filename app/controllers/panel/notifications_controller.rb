
class Panel::NotificationsController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource

	autocomplete :article, :name, full: true
	autocomplete :station, :name, full: true
	autocomplete :camera, :name, full: true

	def index
		@notifications = Notification.all
	end

	def new
		@notification = Notification.new	
	end

	def create
	
		@notification = Notification.new(notification_params)
		if @notification.save
			# sns = Aws::SNS::Client.new

	# Device.where(operating_system: "ios").each do |device|
		
	# 	p "Device token"
	# 	p device.token
	# 	endpoint = sns.create_platform_endpoint(platform_application_arn: "arn:aws:sns:us-west-1:123129123171:app/APNS/GlobalMediaProd", token: device.token)
		
		
	# 	if @notification.wants_keys?
	# 		p "quiere llaves"
	# 		iphone_notification = {
	# 		aps: {
	# 			alert: @notification.body, sound: true, bagde: 0, extra: { key: @notification.key,
 #            	key_id: @notification.key_id }
	# 			}
	# 		}
	# 	else
	# 		iphone_notification = {
	# 			aps: {
	# 				alert: @notification.body, sound: true, bagde: 0, extra: {}
	# 			}
	# 		}
	# 	end
		

	# 	message = {
	# 		default: @notification.body,
	# 		APNS_SANDBOX: iphone_notification.to_json,
	# 		APNS: iphone_notification.to_json
	# 	}
	# 	p "endpoint 2" 
	# 	p endpoint
	# 	begin
	# 		resp = sns.publish({
	# 			target_arn: endpoint.endpoint_arn,
	# 			message: message.to_json,
	# 			message_structure: "json"
	# 			}
						
	# 		)
	# 	rescue => ex
	# 		p "error notis"
	# 		logger.error ex.message
	# 	end
	# end

		
			SendNotificationsJob.perform_later @notification
			redirect_to panel_notifications_path
		else
			render action: "new"
		end
	end

	

	private
		def notification_params
			params.require(:notification).permit(:title, :body, :key, :key_id, :wants_keys)
		end

		def set_notification
			@notification = Notification.find(params[:id])
		end
		

end
