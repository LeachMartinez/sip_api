class ContactsController < ApplicationController
  def index
    users = []

    User.find_each do |user|
      users << user.attributes
    end
    render json: users
  end
end
