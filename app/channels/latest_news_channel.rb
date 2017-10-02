class LatestNewsChannel < ApplicationCable::Channel  
	def subscribed
    	stream_from 'latest'
  	end

end 