require 'bcrypt'

class User
  include Mongoid::Document
  include OmniAuth::Identity::Models::Mongoid

  has_many :authentications
  has_many :posts

  field :email, type: String
  field :name, type: String
  field :password_digest, :type => String

  def self.from_omniauth(auth)
    user = User.find_or_initialize_by(email: auth['info']['email'])
    user.name = auth["info"]["name"] if user.name.nil?
    # need to have some password set when creating a new user from OmniAuth
    unencrypted_password = RandomString.create
    user.password_digest = BCrypt::Password.create unencrypted_password
    user
  end
end
