threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

# Número de workers (procesos). Aumenta la concurrencia en máquinas con varios núcleos.
# Render soporta esto. Si estás en local en Windows, esto puede causar errores (usa solo 1).
workers ENV.fetch("WEB_CONCURRENCY") { 2 }.to_i

port ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

preload_app!

rackup DefaultRackup

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

plugin :tmp_restart