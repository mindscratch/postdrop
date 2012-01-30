class IdentitiesController < ApplicationController

  skip_before_filter :login_required

  def new
    @identity = env['omniauth.identity']
  end

end
