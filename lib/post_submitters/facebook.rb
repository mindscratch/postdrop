require 'fb_graph'

module PostSubmitters
  class Facebook
    def submit(post, user, authentication)
      raise "Unable to submit post (id=#{post.id}) with #{self.class.name.split('::').last}: access token unknown" if authentication.access_token.nil?

      user = FbGraph::User.me authentication.access_token
      # TODO setup application settings (yaml, settingslogic, something) and put project/app name in it instead of hard coding below
      user.feed!(message: post.content, name: "Post Drop", description: "drop a post everywhere but keep your own copy")
      true
    end
  end
end