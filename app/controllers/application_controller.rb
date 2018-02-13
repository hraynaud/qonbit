class ApplicationController < ActionController::API
 before_action :authenticate_request, only: [:current_user]

 def preflight
   head :ok
 end

 def current_user
   render json: @current_user, only: [:handle]
 end

 def index
   render file: 'public/index.html'
 end


private
def pwd_login_success jwt
  if jwt
    render json: {jwt: jwt}, status: 200
  else
    render json: 'authentication failed', status: 401
  end
end


def pwd_login_fail error="Authentication failed"
  render json: error, status: 401
end

  def authenticate_request
    begin
      id = JWT.decode(request.headers['Authorization'], Rails.application.secrets.secret_key_base)[0]['uid']
      @current_user = User.find(id)
    rescue JWT::DecodeError
      render json: 'authentication failed', status: 401
    end
  end

   def base_client_path
     "#{origin}?jwt="
   end

  def origin
    ENV['ORIGIN']
  end

end
