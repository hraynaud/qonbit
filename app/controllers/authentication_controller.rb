class AuthenticationController < ApplicationController

  def request_token
    request_token = Authentication.twitter_login
    redirect_to request_token.authorize_url(oauth_callback: OAUTH_CALLBACK)
  end

  def access_token
    req_token = Oauth.find_by(token: params[:oauth_token])

    if req_token
      acc_token = Authentication.convert_to_access_token req_token, params
      user_oauth_token = UserOauthToken.find_by(uid: acc_token.params[:user_id]) ||
        Authentication.register_by_auth_token(acc_token)

      redirect_to "#{origin}?jwt=#{Authentication.jwt_by_oauth(user_oauth_token)}"
    else 
      #TBD ????
    end
  end

  def login
    jwt = Authentication.login_by_password  params[:email], params[:password]

    if jwt
      pwd_login_success jwt
    else
      pwd_login_fail
    end
  end

  private

  def origin
    ENV['ORIGIN']
  end

end
