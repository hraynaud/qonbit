class Authentication
  class << self

    def twitter_login
      request_token = TWITTER.get_request_token(oauth_callback: OAUTH_CALLBACK)
      store request_token
      request_token
    end

    def store request_token
      Oauth.create(token: request_token.token, secret: request_token.secret)
    end

    def login_by_oauth_token oauth, request_params
      request_token = OAuth::RequestToken.new(TWITTER, oauth.token, oauth.secret)
      jwt_for UserFromToken.new.get(request_token, request_params[:oauth_verifier])
    end

    def jwt_for user
      id = user.uid || user.id
      JWT.encode({uid: user.uid, handle: user.handle, exp: 1.day.from_now.to_i}, Rails.application.secrets.secret_key_base)
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
      user = User.find_or_create_by(uid: access_token.params[:user_id]) do |u| 
        u.handle = access_token.params[:screen_name] 
        #sets random password to avoid validation errors since email and password
        #auth is also supported
        u.password = u.password_confirmation = SecureRandom.urlsafe_base64(n=6) 
      end
    end
  end

end
