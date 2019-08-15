class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create
  rescue_from UserAuthenticator::AuthenticationError, with: :authentication_error
  def create
    authenticator = UserAuthenticator.new(params[:code])
    authenticator.perform

    render json: authenticator.access_token, status: :created
  end

  def destroy
    current_user.access_token.destroy
  end
end
