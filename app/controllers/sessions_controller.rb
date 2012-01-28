class SessionsController < ApplicationController
  def new
  end

  def create
    omniauth_hash = env['omniauth.auth']

    auth = Authentication.from_omniauth(omniauth_hash)
    user = User.from_omniauth(omniauth_hash)

    user.save unless user.changes.empty?
    user.authentications << auth

    # TODO only send mail on new registration
    UserMailer.registration_confirmation(user).deliver

    session[:user_id] = user.id
    session[:auth_id] = auth.id
    redirect_to root_url, notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    session[:auth_id] = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: 'Authentication failed, please try again.'
  end
end
