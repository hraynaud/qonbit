class AuthenticationController < ApplicationController

  def request_token
    request_token = Authentication.twitter_login
    redirect_to request_token.authorize_url(oauth_callback: OAUTH_CALLBACK)
  end

  def access_token
    oauth = Oauth.find_by(token: params[:oauth_token])
    if oauth.present?
      jwt = Authentication.login_by_oauth_token oauth, params
      redirect_to "#{origin}?jwt=#{jwt}"
    else
      #TBD
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
