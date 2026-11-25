# Protección contra robots y ráfagas de peticiones.
# Sin estas reglas, un solo robot pidiendo cientos de páginas por minuto ocupa todos los hilos de Puma
# y el sitio completo se queda esperando (hasta robots.txt tardaba 30+ segundos).

class Rack::Attack
  # Contadores en la memoria de cada proceso (no depende de memcached).
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new(size: 16.megabytes)

  STATIC = %r{\A/(assets|packs|images|uploads|fonts|favicon|apple-touch|android-chrome|robots\.txt)}i

  # Robots de herramientas SEO y scrapers que no traen lectores y consumen mucho.
  BAD_BOTS = /
    bytespider|petalbot|semrushbot|ahrefsbot|mj12bot|dotbot|blexbot|dataforseobot|serpstatbot|
    megaindex|barkrowler|seekportbot|zoominfobot|imagesiftbot|awario|magpie-crawler|
    epochal-search|exasearchbot|
    python-requests|go-http-client|scrapy|httpclient|libwww-perl|java\/
  /xi

  blocklist("robots abusivos") do |req|
    BAD_BOTS.match?(req.user_agent.to_s)
  end

  # El panel de la redacción no se limita (toda la oficina sale por la misma IP y el autocompletado pide mucho).
  PANEL = %r{\A/(panel|admin|users|admins)}i

  # Ráfagas: más de 150 páginas por minuto desde la misma IP. Una persona lee muchísimo menos;
  # el margen alcanza para una oficina o un café con varias personas en la misma red.
  throttle("paginas por ip", limit: 150, period: 60) do |req|
    req.ip unless STATIC.match?(req.path) || PANEL.match?(req.path)
  end

  # Búsqueda pública: de las consultas más caras de la base.
  throttle("busquedas por ip", limit: 30, period: 60) do |req|
    req.ip if !PANEL.match?(req.path) && (req.path.include?("search") || req.path.include?("autocomplete"))
  end

  # Intentos de inicio de sesión al panel.
  throttle("logins por ip", limit: 10, period: 60) do |req|
    req.ip if req.post? && req.path.include?("sign_in")
  end

  self.blocklisted_responder = lambda do |_req|
    [403, { "Content-Type" => "text/plain" }, ["Forbidden\n"]]
  end

  self.throttled_responder = lambda do |req|
    retry_after = (req.env["rack.attack.match_data"] || {})[:period] || 60
    [429, { "Content-Type" => "text/plain", "Retry-After" => retry_after.to_s }, ["Demasiadas peticiones. Intenta de nuevo en un minuto.\n"]]
  end
end

# Deja rastro en los logs de Render para saber a quién se frena.
ActiveSupport::Notifications.subscribe(/rack_attack/) do |_name, _start, _finish, _id, payload|
  req = payload[:request]
  next unless req && %i[throttle blocklist].include?(req.env["rack.attack.match_type"])
  Rails.logger.warn("[RackAttack] #{req.env['rack.attack.match_type']} #{req.env['rack.attack.matched']} ip=#{req.ip} ua=#{req.user_agent.to_s[0, 120]} path=#{req.path}")
end
