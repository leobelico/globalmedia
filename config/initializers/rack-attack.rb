class Rack::Attack

  # empresa
  safelist('allow company') do |req|
    req.ip == '187.189.250.162'
  end

  # bloquear bots agresivos
  blocklist('bad bots') do |req|
    req.user_agent =~ /SemrushBot|PetalBot|TikTokSpider|YandexBot|Amazonbot/i
  end

  # bloqueo ips malas
  blocklist('block known bad IPs') do |req|
    ['52.233.27.230','85.241.15.110','90.94.138.253'].include?(req.ip)class Rack::Attack

safelist('allow company') do |req|
req.ip == '187.189.250.162'
end

safelist('allow good bots') do |req|
req.user_agent =~ /Googlebot|bingbot|facebookexternalhit|meta-externalagent/i
end

blocklist('bad bots') do |req|
req.user_agent =~ /SemrushBot|PetalBot|TikTokSpider|YandexBot|Amazonbot|GPTBot|ClaudeBot|OAI-SearchBot/i
end

blocklist('hashtag scraping') do |req|
req.path.include?('/articles/hashtag') &&
req.user_agent =~ /bot|spider|crawler/i
end

blocklist('crazy pagination') do |req|
page = req.params["page"].to_i
page > 100
end

blocklist('block known bad IPs') do |req|
[
'52.233.27.230',
'85.241.15.110',
'90.94.138.253'
].include?(req.ip)
end

throttle('req/ip', limit: 100, period: 1.minute) do |req|
req.ip
end

end

  end

  # limitar requests
  throttle('req/ip', limit: 120, period: 1.minute) do |req|
    req.ip
  end

end