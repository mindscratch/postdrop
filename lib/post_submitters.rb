require 'post_submitters/facebook'

module PostSubmitters

  def self.submit_post(post, user, providers=[])

    # TODO need validation, check params
    authentications = user.authentications.where(:provider.in => providers)
    authentications.each do |auth|
      submitter = submitter_for_provider auth.provider
      submitter.submit post, user, auth
    end

    true
  end

  def self.submitter_for_provider(provider)
    provider_constant = PostSubmitters.constants.select {|c| c.to_s.underscore == provider}.first
    raise "Unable to locate post submitter (provider=#{provider})" if provider_constant.nil?

    submitter = PostSubmitters.const_get(provider_constant).new
  end

end