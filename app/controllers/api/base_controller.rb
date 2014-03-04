class Api::BaseController < ApplicationController

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @api_key ||= ApiKey.where(access_token: token)
      @api_key.present?
    end
    # @api_key ||= ApiKey.find_by_access_token(params[:access_token])
    # head :unauthorized unless @api_key
  end

  def api_user
    @api_key.user
  end

end