class AuthorizeController < ActionController::API
  def sign_in
    user = User.find_by(username: auth_params[:username])
    return head :unauthorized unless user

    return head :forbidden unless user.authenticate(auth_params[:password])

    tokens = generate_tokens(user, {
      remote_ip: request.remote_ip,
      user_agent: request.user_agent
    })

    render json: tokens
  end

  def sign_up
    
  end

  def refresh
    return head :forbidden if request.headers["Refreshtoken"].blank?
    return head :forbidden if request.headers["Refreshtoken"] == "Bearer undefined" || request.headers["Refreshtoken"] == "Bearer null"
    begin
      auth_user = AuthService.new(header: request.headers["Refreshtoken"]).auth
    rescue AuthorizationError => e
      p e.message
      return head e.exception_type
    end

    tokens = generate_tokens(auth_user, {
      remote_ip: request.remote_ip,
      user_agent: request.user_agent
    })

    render json: tokens
  end

  def logout

  end

  private
    def auth_params
      @auth_params ||= params.permit(:username, :password)
    end

    def generate_tokens(user, request_data)
      tokens = {}
      %w[access refresh].each do |token|
        tokens[:"#{token}_token"] = AuthService.new.send("generate_#{token}_token", {
          id: user.id,
          username: user.username,
          first_name: user.first_name,
          last_name: user.last_name,
          type: token,
          user_agent: request_data[:user_agent],
          ip: request_data[:remote_ip]
        })
      end

      tokens.symbolize_keys!
    end
end
