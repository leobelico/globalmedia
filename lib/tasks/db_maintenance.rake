namespace :db do
  desc "Termina conexiones idle de Puma con más de X minutos sin uso"
  task kill_idle_connections: :environment do
    idle_minutes = ENV.fetch("IDLE_CONNECTION_MINUTES", 20).to_i

    sql = <<~SQL
      SELECT pid, application_name, now() - state_change AS idle_since
      FROM pg_stat_activity
      WHERE state = 'idle'
        AND application_name LIKE '%puma%'
        AND pid <> pg_backend_pid()
        AND now() - state_change > interval '#{idle_minutes} minutes'
    SQL

    connections = ActiveRecord::Base.connection.select_all(sql)

    if connections.empty?
      puts "No hay conexiones idle de más de #{idle_minutes} minutos. Todo en orden."
    else
      puts "Encontradas #{connections.count} conexiones idle de más de #{idle_minutes} minutos:"

      connections.each do |row|
        pid = row["pid"]
        puts "  - Terminando PID #{pid} (idle desde: #{row["idle_since"]})"
        ActiveRecord::Base.connection.execute("SELECT pg_terminate_backend(#{pid})")
      end

      puts "Listo. #{connections.count} conexiones liberadas."
    end
  end
end