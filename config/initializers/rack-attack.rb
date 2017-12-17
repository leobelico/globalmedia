Rack::Attack.blocklist('block 52.233.27.230') do |req|
  # Requests are blocked if the return value is truthy
  '52.233.27.230' == req.ip
end