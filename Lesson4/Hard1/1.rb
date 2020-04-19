class SecretFile
  def initialize(secret_data, security_log)
    @data = secret_data
    @security_log = security_log # assumes its already a SecurityLogger object
  end

  def data
    @data
    @security_log.create_log_entry
  end
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end