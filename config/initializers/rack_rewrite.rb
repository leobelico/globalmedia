Rails.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
  r301 %r{.*}, 'http://www.globalmedia.mx$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] != 'www.globalmedia.mx'
  }
end if Rails.env == 'production'