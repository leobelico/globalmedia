if ENV["ENABLE_PROFILER"] == "true"
  require 'rack-mini-profiler'

  Rack::MiniProfiler.config.position = 'bottom-right'
  Rack::MiniProfiler.config.start_hidden = true
  Rack::MiniProfiler.config.pre_authorize_cb = lambda do |env|
    # Solo tu IP puede verlo
    ['127.0.0.1', '::1', '187.189.250.162'].include?(env['REMOTE_ADDR'])
  end
end
