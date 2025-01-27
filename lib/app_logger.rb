class AppLogger
  def initialize(name)
    @id = name.to_s
  end

  def info(message, details = {})
    log(:info, message, details)
  end

  def error(message, details = {})
    log(:error, message, details)
  end

  def warn(message, details = {})
    log(:warn, message, details)
  end

  private

  def log(level, message, details)
    Rails.logger.send(level) do
      {
        identification: @id,
        message: message,
        details: details.transform_keys(&:to_sym),
        timestamp: Time.current.utc
      }.to_json
    end
  end
end
