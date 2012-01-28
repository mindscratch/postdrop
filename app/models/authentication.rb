class Authentication
  include Mongoid::Document

  belongs_to :user

  field :provider, type: String
  field :uid, type: String

  field :access_token, type: String
  field :access_secret, type: String

  def self.from_omniauth(omniauth_hash)
    auth = Authentication.find_or_initialize_by(provider: omniauth_hash['provider'], uid: omniauth_hash.fetch('uid'))
    if omniauth_hash['credentials']
      auth.access_token = omniauth_hash['credentials'].fetch 'token', nil
      auth.access_secret = omniauth_hash['credentials'].fetch 'secret', nil
    end
    auth
  end
end

