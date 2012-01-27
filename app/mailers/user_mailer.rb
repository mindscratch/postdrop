class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def registration_confirmation(user)
    @user = user
    if user.authentications && user.authentications.count > 0
      provider = user.authentications.first.provider
      unless provider == 'identity'
        @provider = provider.split(/_/).first.capitalize
      else
        @provider = nil
      end
    else
      @provider = nil
    end

    mail(:to => user.email, :subject => "[#{@user.name}] Welcome to Post Drop")
  end
end
