class ContactsController < ApplicationController
  def index
    users = []
    limit = params[:limit] || 50
    ofset = params[:ofset] || 0

    if params[:searchParams].present?
      users = []
      User.where("username LIKE '%#{params[:searchParams]}%' OR
                  first_name LIKE '%#{params[:searchParams]}%' OR
                  last_name LIKE '%#{params[:searchParams]}%' OR
                  email LIKE '%#{params[:searchParams]}%'")
          .limit(limit)
          .offset!(ofset)
          .find_each do |user|
            users << user.attributes
          end
      return render json: users
    end

    User.limit(limit).offset(ofset).find_each do |user|
      next if user.id == @user.id

      users << user.attributes
    end
    render json: users
  end
end
