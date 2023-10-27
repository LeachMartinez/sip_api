class UserController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    render json: @user.attributes
  end

  def show
    render json: @find_user.attributes
  end

  private
    def find_user
      @find_user ||= User.find(params[:id])
    end
end
