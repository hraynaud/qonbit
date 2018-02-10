class AuthenticationController < ApplicationController

  def request_token
    request_token = TWITTER.get_request_token(oauth_callback: oauth_callback)
    Oauth.create(token: request_token.token, secret: request_token.secret)

    redirect_to request_token.authorize_url(oauth_callback: oauth_callback)
  end

  def access_token
    oauth = Oauth.find_by(token: params[:oauth_token])

    if oauth.present?
      jwt = Authentication.login_by_oauth_token oauth, params
      redirect_to "#{origin}?jwt=#{jwt}"
    else
      redirect_to origin
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

  def oauth_callback
    ENV['OAUTH_CALLBACK']
  end
end
