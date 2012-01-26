class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :current_auth

  #######
  private
  #######

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Mongoid::Errors::DocumentNotFound
      @current_user
    end
  end

  def current_auth
    begin
      @current_auth ||= Authentication.find(session[:auth_id]) if session[:auth_id]
    rescue Mongoid::Errors::DocumentNotFound
      @current_auth
    end
  end
end
