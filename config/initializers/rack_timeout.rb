Rails.application.config.middleware.delete Rack::Timeout

Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout,
  service_timeout: 25,  # 25 segundos para toda la petición
  wait_timeout: 5,
  wait_overtime: 60
