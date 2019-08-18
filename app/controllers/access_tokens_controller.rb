class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create
  rescue_from UserAuthenticator::AuthenticationError, with: :authentication_error
  def create
    authenticator = UserAuthenticator.new(authentication_params)
    authenticator.perform

    render json: authenticator.access_token, status: :created
  end

  def destroy
    current_user.access_token.destroy
  end

  private

  def authentication_params
    (standard_outh_params || params.permit(:code)).to_h.symbolize_keys
  end

  def standard_outh_params
    params.dig(:data, :attributes)&.permit(:login, :password)
  end
end
