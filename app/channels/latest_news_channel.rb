class LatestNewsChannel < ApplicationCable::Channel  
	def subscribed
    	stream_from 'latest_news'
  	end

end 