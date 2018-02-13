class AuthenticationController < ApplicationController

  def request_token
    redirect_to Authentication.login_by_provider params[:provider]
  end

  def access_token
    request_token = Oauth.find_by(token: params[:oauth_token])

    if request_token
      user_oauth_token = Authentication.produce_user_auth_token(request_token, params[:oauth_verifier], params[:provider])
      request_token.delete
      redirect_to "#{base_client_path}#{Authentication.jwt_by_oauth(user_oauth_token)}"
    else
      #TBD ????
    end
  end

  def login_with_email_pwd
    auth = DirectAuth.find_by_email(params[:email])
    if auth && auth.user  && auth.authenticate(params[:password])
      render json: {jwt: Authentication.jwt_for(auth.user_id, auth.email)}, status: 200
    end
  end

  def register_with_email_pwd
    user = Authentication.register_directly(params[:email], params[:password])

    if user.valid?
      jwt = Authentication.jwt_for(user.id, user.auth_email)
      render json: {jwt: jwt}, status: 200
    else
      response.headers["X-Message"]= "Unable to register user: #{user_auth.errors.full_messages}"
      head :unprocessable_entity
    end
  end

  private

end
