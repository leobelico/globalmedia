Rack::Attack.blacklist('block <ip>') do |req|
  # if variable `block <ip>` exists in cache store, then we'll block the request
  Rails.cache.fetch("block #{req.ip}").blank?
end