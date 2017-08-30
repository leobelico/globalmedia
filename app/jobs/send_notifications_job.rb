class SendNotificationsJob < ApplicationJob
  queue_as :default

  def perform(notification)
    sns = Aws::SNS::Client.new

	Device.where(operating_system: "ios").each do |device|
		
			
		endpoint = sns.create_platform_endpoint(platform_application_arn: "arn:aws:sns:us-west-1:568746846919:app/APNS_SANDBOX/Global", token: device.token)
		
		
		if notification.wants_keys?
			p "quiere llaves"
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

		resp = sns.publish({
			target_arn: endpoint.endpoint_arn,
			message: message.to_json,
			message_structure: "json"
			}
					
		)
	end
  end
end
