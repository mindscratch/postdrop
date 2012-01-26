class Authentication
  include Mongoid::Document

  belongs_to :user

  field :provider, type: String
  field :uid, type: String
  field :access_token, type: String

  def self.from_omniauth(omniauth_hash)
    auth = Authentication.find_or_initialize_by(provider: omniauth_hash['provider'], uid: omniauth_hash.fetch('uid'))
    auth.access_token = omniauth_hash.fetch 'oauth_token', nil
    auth
  end
end

