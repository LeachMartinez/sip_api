class AuthService
  def initialize(header: nil)
    @header = header
  end

  def auth
    data = JwtService.decode(@header.split[1])[0].symbolize_keys!

    if data[:type] == "refresh" && !check_refresh_token(data[:id], @header.split[1])
      raise AuthorizationError.new "Не верный токен!", :forbidden
    else
      RefreshToken.find_by(user_id: data[:id], token: @header.split[1])&.delete
    end

    user = User.find(data[:id])
    raise AuthorizationError.new "Пользователь не найден", :unauthorized unless user

    user
  rescue JWT::ExpiredSignature
    raise AuthorizationError.new "Срок действия токена истек", :unauthorized
  end

  def generate_refresh_token(data)
    token = JwtService.new(data: data, type: "refresh").encode
    RefreshToken.create(token: token, user_id: data[:id], user_agent: data[:user_agent], ip: data[:ip])
    token
  end

  def generate_access_token(data)
    JwtService.new(data: data, type: "access").encode
  end

  private
    def check_refresh_token(user_id, token)
      RefreshToken.exists?(user_id: user_id, token: token)
    end
end
