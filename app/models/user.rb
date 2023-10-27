class User < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  has_secure_password
  has_one :sip_account
  has_many :refresh_token
  after_create :create_sip_account

  def attributes
    {
      id: id,
      firstName: first_name,
      lastName: last_name,
      avatar: avatar,
      email: email,
      username: username
    }
  end

  private
    def create_sip_account
      SipAccount.create(username: "sip-#{username}", password: password_digest, user_id: id)
    end
end
