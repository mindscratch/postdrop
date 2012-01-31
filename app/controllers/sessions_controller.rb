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
      flash[:success] = "Welcome to Post Drop!"
      UserMailer.registration_confirmation(user).deliver
    else
      flash[:info] = "Welcome back!"
    end

    session[:user_id] = user.id
    session[:auth_id] = auth.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    session[:auth_id] = nil
    flash[:info] = 'Signed out!'
    redirect_to root_url
  end

  def failure
    flash[:error] = 'Authentication failed, please try again.'
    redirect_to root_url
  end
end
