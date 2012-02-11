class AuthenticationsController < ApplicationController

  def create
    # TODO validate param
    provider = params[:provider]
    session[:route_after_oauth] = root_url
    redirect_to "/auth/#{provider}"
  end

end
