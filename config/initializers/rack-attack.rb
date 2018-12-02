class Rack::Attack
	Rack::Attack.blocklist('block 52.233.27.230') do |req|
	  # Requests are blocked if the return value is truthy
	  ['52.233.27.230', '85.241.15.110', '90.94.138.253']== req.ip
	end

	Rack::Attack.throttle('req/ip', :limit => 500, :period => 5.minutes) do |req|
	  # If the return value is truthy, the cache key for the return value
	  # is incremented and compared with the limit. In this case:
	  #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
	  #
	  # If falsy, the cache key is neither incremented nor checked.

	  req.ip
	end


	Rack::Attack.blocklist('fail2ban pentesters') do |req|
	  # `filter` returns truthy value if request fails, or if it's from a previously banned IP
	  # so the request is blocked
	  Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}", :maxretry => 3, :findtime => 10.minutes, :bantime => 5.minutes) do
	    # The count for the IP is incremented if the return value is truthy
	    CGI.unescape(req.query_string) =~ %r{/etc/passwd} ||
	    req.path.include?('/etc/passwd') ||
	    req.path.include?('wp-admin') ||
	    req.path.include?('wp-login') ||
	    req.path.include?('StdOut.ReadAll') ||
	    req.path.include?('trace.ax') ||
	    req.path.include?('WAITFOR')

	  end
	end
	Rack::Attack.blocklisted_response = lambda do |env|
	  # Using 503 because it may make attacker think that they have successfully
	  # DOSed the site. Rack::Attack returns 403 for blocklists by default
	  [ 503, {}, ['Blocked']]
	end



	# Rack::Attack.throttled_response = lambda do |env|
	#   # NB: you have access to the name and other data about the matched throttle
	#   #  env['rack.attack.matched'],
	#   #  env['rack.attack.match_type'],
	#   #  env['rack.attack.match_data']

	#   # Using 503 because it may make attacker think that they have successfully
	#   # DOSed the site. Rack::Attack returns 429 for throttling by default
	#   [ 503, {}, ["Server Error\n"]]
	# end

end