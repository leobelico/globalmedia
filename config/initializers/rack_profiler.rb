if ENV['RACK_MINI_PROFILER'] == 'true'
  require 'rack-mini-profiler'

  # Inicializa en el middleware
  Rack::MiniProfilerRails.initialize!(Rails.application)

  # Muestra el panel en la esquina inferior derecha
  Rack::MiniProfiler.config.position = 'bottom-right'

  # Soporte para Turbo/Hotwire si lo usas
  Rack::MiniProfiler.config.enable_hotwire_turbo_drive_support = true

  # ⚠️ Solo activa para tu IP (ajusta la IP real tuya)
  Rack::MiniProfiler.config.authorization_mode = :whitelist
  Rack::MiniProfiler.config.pre_authorize_cb = lambda do |env|
    ip = env['REMOTE_ADDR']
    allowed_ips = ['127.0.0.1', '::1', '187.189.250.162']
    allowed_ips.include?(ip)
  end
end
