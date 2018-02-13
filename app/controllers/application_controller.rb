class ApplicationController < ActionController::API

  def preflight
    head :ok
  end

  def index
    render file: 'public/index.html'
  end

  private

  def authenticate_request
    @current_user = Authentication.login_with_jwt request.headers['Authorization']
    render json: 'authentication failed', status: 401 if @current_user.nil?
  end

  def base_client_path
    "#{origin}?jwt="
  end

  def origin
    ENV['ORIGIN']
  end

  def respond_with_error msg
    set_response_msg msg
    head :unprocessable_entity
  end

  def set_response_msg msg
    response.headers["X-Message"]= msg
  end

end
