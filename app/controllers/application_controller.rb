class ApplicationController < ActionController::API

 def preflight
   head :ok
 end


 def index
   render file: 'public/index.html'
 end


private

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
