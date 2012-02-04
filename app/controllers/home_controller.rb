class HomeController < ApplicationController
  skip_before_filter :login_required
  def index
    if logged_in?
      redirect_to posts_url
    else
      redirect_to signin_url
    end
  end
end

