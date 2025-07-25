class SendNotificationsJob < ApplicationJob
  queue_as :default

  def perform(notification)
    sns = Aws::SNS::Client.new

	Device.where(operating_system: "ios").each do |device|
		
		endpoint = sns.create_platform_endpoint(platform_application_arn: "arn:aws:sns:us-west-1:123129123171:app/APNS/GlobalMediaProd", token: device.token)
		
		
		if notification.wants_keys?
			
			iphone_notification = {
			aps: {
				alert: notification.body, sound: true, bagde: 0, extra: { key: notification.key,
            	key_id: notification.key_id }
				}
			}
		else
			iphone_notification = {
				aps: {
					alert: notification.body, sound: true, bagde: 0, extra: {}
				}
			}
		end
		

		message = {
			default: notification.body,
			APNS_SANDBOX: iphone_notification.to_json,
			APNS: iphone_notification.to_json
		}
	
		begin
			resp = sns.publish({
				target_arn: endpoint.endpoint_arn,
				message: message.to_json,
				message_structure: "json"
				}
						
			)
		rescue => ex
			p "error notis"
			logger.error ex.message
		end
	end

	Device.where(operating_system: "android").each do |device|
	
		endpoint = sns.create_platform_endpoint(platform_application_arn: "arn:aws:sns:us-west-1:123129123171:app/GCM/android2", token: device.token)
		
		
		if notification.wants_keys?
			p "quiere llaves"
			message = {
				default: { data: notification.body }.to_json,
				GCM: { data: { message: notification.body, key: notification.key, key_id: notification.key_id} }.to_json
			}
		else
			message = {
				default: { data: notification.body }.to_json,
				GCM: { data: { message: notification.body } }.to_json
			}
		end
		
		#{
# "GCM": "{ \"data\": { \"message\": \"hola\", \"key\": \"article\", \"key_id\": \"440\" } }"
# }
		
	
		begin 
			resp = sns.publish({
				target_arn: endpoint.endpoint_arn,
				message: message.to_json,
				message_structure: "json"
				}
						
			)
		rescue => ex
			p "error notis"
			logger.error ex.message
		end
	end
  end
end
