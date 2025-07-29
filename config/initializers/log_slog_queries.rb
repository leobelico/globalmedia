ActiveSupport::Notifications.subscribe('sql.active_record') do |_, started, finished, _, payload|
  duration = (finished - started) * 1000
  if duration > 500 # milisegundos
    Rails.logger.warn("[SlowQuery] (#{duration.round(1)}ms): #{payload[:sql]}")
  end
end
