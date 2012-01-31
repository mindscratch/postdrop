class SessionsController < ApplicationController

skip_before_filter :login_required

  def new
  end

  def create
    omniauth_hash = env['omniauth.auth']

    auth = Authentication.from_omniauth(omniauth_hash)
    user = User.from_omniauth(omniauth_hash)
    new_user = !user.persisted?

    user.save unless user.changes.empty?
    user.authentications << auth

    # TODO only send mail on new registration
    if new_user
      UserMailer.registration_confirmation(user).deliver
    end

    session[:user_id] = user.id
    session[:auth_id] = auth.id
    redirect_to root_url, success: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    session[:auth_id] = nil
    redirect_to root_url, info: 'Signed out!'
  end

  def failure
    redirect_to root_url, error: 'Authentication failed, please try again.'
  end
end
