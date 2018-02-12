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
    user_pwd_auth = UserLoginPwdAuth.find_by_email(params[:email])
    if user_pwd_auth && user_pwd_auth.user  && user_pwd_auth.authenticate(params[:password])
     redirect_to "#{base_client_path}#{Authentication.login_by_password(user_pwd_auth)}"
    end
  end

  def register_with_email_pwd
     user = User.new
     user.build_user_login_pwd_auth(email: params[:email], password:params[:password]) 
     if user.save
       redirect_to "#{base_client_path}#{Authentication.login_by_password(user.user_login_pwd_auth)}"
     else
       response.headers["X-Message"]= "Unable to register user: #{user.errors.full_messages}"
       head :unprocessable_entity
     end
  end

  private
   def base_client_path
     "#{origin}?jwt="
   end

  def origin
    ENV['ORIGIN']
  end

end
