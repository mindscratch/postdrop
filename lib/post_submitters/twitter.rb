require 'twitter'

module PostSubmitters
  class Twitter
    def submit(post, user, authentication)
      raise "Unable to submit post (id=#{post.id}) with #{self.class.name.split('::').last}: access token unknown" if authentication.access_token.nil?
      raise "Unable to submit post (id=#{post.id}) with #{self.class.name.split('::').last}: access secret unknown" if authentication.access_secret.nil?

      twitter.configure do |config|
        config.consumer_key = POSTDROP_TWITTER_KEY
        config.consumer_secret = POSTDROP_TWITTER_SECRET
        config.oauth_token = authentication.access_token
        config.oauth_secret = authentication.access_secret
      end

      twitter.update post.content(0, 140)
      true
    end

    #######
    private
    #######
    def twitter
      ::Twitter
  end
end