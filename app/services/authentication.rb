class Authentication
  class << self

    def twitter_login
      request_token = TWITTER.get_request_token(oauth_callback: OAUTH_CALLBACK)
      store request_token, "twitter"
      request_token
    end

    def store request_token, provider
      Oauth.find_or_create_by(token: request_token.token, secret: request_token.secret)
    end

    def register_by_auth_token access_token
      token = UserOauthToken.new
      token.tap do |oauth|
        oauth.build_user
        oauth.uid    = access_token.params[:user_id]
        oauth.handle =  access_token.params[:screen_name]
        oauth.token  = access_token.params[:oauth_token]
        oauth.secret =  access_token.params[:oauth_token_secret]
        oauth.save
      end
    end

    def convert_to_access_token oauth, request_params
      request_token = OAuth::RequestToken.new(TWITTER, oauth.token, oauth.secret)
      request_token.get_access_token(oauth_verifier: request_params[:oauth_verifier])
    end

    def jwt_by_oauth token
      jwt_for token.user_id, token.handle
    end

    def jwt_for user_id, user_login
      JWT.encode({uid: user_id, login: user_login, exp: 1.day.from_now.to_i}, Rails.application.secrets.secret_key_base)
    end

    def login_by_password email, pwd
      user = User.find_by email: email
      if user && user.authenticate(pwd) != false
        jwt_for user
      else  #If authentication fails then...
        nil
      end
    end

  end

  class UserFromToken

    def get request_token, oauth_verifier 

      access_token = request_token.get_access_token(oauth_verifier: oauth_verifier)

      user = User.new
      user.tap do |u|
        u.user_oauth_tokens.build(
          uid: access_token.params[:user_id],
          handle:  access_token.params[:screen_name],
          token: access_token.params[:oauth_token],
          secret: access_token.params[:oauth_token_secret],
        )
        u.save
      end
    end

  end

end
