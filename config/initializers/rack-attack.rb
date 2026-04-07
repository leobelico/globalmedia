class Rack::Attack

  safelist('allow company') do |req|
    req.ip == '187.189.250.162'
  end

  safelist('allow good bots') do |req|
    ua = req.user_agent.to_s
    ua =~ /Googlebot|bingbot|facebookexternalhit|meta-externalagent|Facebot/i
  end

  blocklist('bad bots') do |req|
    ua = req.user_agent.to_s
    ua =~ /SemrushBot|PetalBot|TikTokSpider|YandexBot|Amazonbot|GPTBot|ClaudeBot|OAI-SearchBot/i
  end

  blocklist('hashtag scraping') do |req|
    ua = req.user_agent.to_s
    req.path.include?('/articles/hashtag') &&
    ua =~ /bot|spider|crawler/i
  end

  blocklist('crazy pagination') do |req|
    req.params && req.params["page"].to_i > 100
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