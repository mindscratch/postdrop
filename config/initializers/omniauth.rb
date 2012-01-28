Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['POSTDROP_FACEBOOK_ID'], ENV['POSTDROP_FACEBOOK_SECRET'], :scope => "email,offline_access,publish_stream"
  provider :google_oauth2, ENV['POSTDROP_GOOGLE_CLIENT_ID'], ENV['POSTDROP_GOOGLE_CLIENT_SECRET']
  provider :twitter, ENV['POSTDROP_TWITTER_KEY'], ENV['POSTDROP_TWITTER_SECRET']
  provider :identity, model: User, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
