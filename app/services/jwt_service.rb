class JwtService
  def initialize(data:, type:)
    @data = data
    @type = type
  end

  def encode
    @data[:exp] = send("exp_#{@type}")
    JWT.encode @data, ENV.fetch("JWT_HMAC_SECRET")
  end

  def self.decode(token)
    JWT.decode token, ENV.fetch("JWT_HMAC_SECRET")
  end

  def exp_access
    Time.now.to_i + 3600
  end

  def exp_refresh
    Time.now.to_i + (15 * 24 * 3600)
  end
end
