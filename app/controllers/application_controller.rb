class ApplicationController < ActionController::API
  before_action :auth_user

  private
    def auth_user
      return head :forbidden if request.headers["Authorization"].blank?
      return head :forbidden if request.headers["Authorization"] == "Bearer null"

      @user = AuthService.new(header: request.headers["Authorization"]).auth
    rescue AuthorizationError => e
      p e.message
      head e.exception_type
    end
end
