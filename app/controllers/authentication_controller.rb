class AuthenticationController < ApplicationController

  def request_token
    redirect_to oauth_login_by_provider params[:provider]
  end

  def access_token
    request_token = Oauth.find_by(token: params[:oauth_token])

    if request_token
      user_oauth_token = Authentication.produce_user_auth_token(request_token, params[:oauth_verifier])
      redirect_to "#{origin}?jwt=#{Authentication.jwt_by_oauth(user_oauth_token)}"
    else
      #TBD ????
    end
  end

  private

  def oauth_login_by_provider provider
    case provider
    when "twitter"
      Authentication.twitter_login
    end

  end

  def origin
    ENV['ORIGIN']
  end

end
