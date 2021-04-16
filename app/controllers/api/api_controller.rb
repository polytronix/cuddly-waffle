class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  private

  def deny_access
    render nothing: true, status: 403
  end
end
