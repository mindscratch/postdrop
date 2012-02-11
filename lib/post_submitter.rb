require 'post_submitter/facebook'
require 'post_submitter/twitter'

module PostSubmitter

  def self.submit_post(post, user, providers=[])

    # TODO need validation, check params
    authentications = user.authentications.where(:provider.in => providers)
    authentications.each do |auth|
      submitter = submitter_for_provider auth.provider
      if submitter.submit(post, user, auth)
        post.posted_to << auth.provider
      end
    end

    true
  end

  def self.submitter_for_provider(provider)
    provider_constant = PostSubmitter.constants.select {|c| c.to_s.underscore == provider}.first
    raise "Unable to locate post submitter (provider=#{provider})" if provider_constant.nil?

    submitter = PostSubmitter.const_get(provider_constant).new
  end
end
