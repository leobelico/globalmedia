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
    ['52.233.27.230','85.241.15.110','90.94.138.253'].include?(req.ip)
  end

  # limitar requests
  throttle('req/ip', limit: 120, period: 1.minute) do |req|
    req.ip
  end

end