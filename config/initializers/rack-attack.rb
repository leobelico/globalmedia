class Rack::Attack
  # BLOQUEO DE IPS ESPECÍFICAS
  Rack::Attack.blocklist('block known bad IPs') do |req|
    [
      '52.233.27.230',
      '85.241.15.110',
      '90.94.138.253'
    ].include?(req.ip)
  end

  # LIMITAR PETICIONES POR IP (THROTTLING)
  Rack::Attack.throttle('req/ip', limit: 500, period: 5.minutes) do |req|
    req.ip
  end

  # BLOQUEO AUTOMÁTICO DE ATAQUES CONOCIDOS (fail2ban)
  Rack::Attack.blocklist('fail2ban pentesters') do |req|
    Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}", maxretry: 3, findtime: 10.minutes, bantime: 5.minutes) do
      query = CGI.unescape(req.query_string)
      path = req.path

      query.include?('/etc/passwd') ||
      path.include?('/etc/passwd') ||
      path.include?('wp-admin') ||
      path.include?('wp-login') ||
      path.include?('StdOut.ReadAll') ||
      path.include?('trace.ax') ||
      path.include?('WAITFOR')
    end
  end

  # RESPUESTA PARA IPS BLOQUEADAS
  Rack::Attack.blocklisted_response = lambda do |_env|
    [503, {}, ['Blocked']]
  end

  # RESPUESTA PERSONALIZADA PARA RATE LIMITING
  Rack::Attack.throttled_response = lambda do |_env|
    [503, {}, ["Server Busy\n"]]
  end
end
