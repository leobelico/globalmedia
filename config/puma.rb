# Puma puede atender múltiples solicitudes por hilo desde un pool interno.
# Estas líneas definen el número mínimo y máximo de hilos usados por cada worker.
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 8 }.to_i
threads threads_count, threads_count

# Puerto en el que Puma escucha las peticiones (por defecto 3000)
port ENV.fetch("PORT") { 3000 }

# Entorno en el que corre Puma (por defecto: desarrollo)
environment ENV.fetch("RAILS_ENV") { "development" }

# Número de workers (procesos). Aumenta la concurrencia en máquinas con varios núcleos.
# Render soporta esto. Si estás en local en Windows, esto puede causar errores (usa solo 1).
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Precarga la app antes de hacer fork de los workers (mejora uso de memoria con Copy-On-Write)
preload_app!

# Configuración del Rack handler
rackup DefaultRackup

# Reestablece conexión con la base de datos en cada worker después del fork
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Permite reiniciar Puma con `rails restart`
plugin :tmp_restart
