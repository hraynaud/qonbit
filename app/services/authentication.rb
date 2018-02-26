class Authentication
  class << self

    def login_by_provider provider
      oauth_handler_for(provider).login
    end

    def produce_user_auth_token req_token, oauth_verifier, provider
      acc_token = convert_to_access_token req_token, oauth_verifier, provider
      token_uid = acc_token.params[:user_id]
      UserOauthToken.find_by(uid: token_uid) || register_by_oauth(acc_token)
    end

    def convert_to_access_token oauth, oauth_verifier, provider
      client = oauth_handler_for(provider).client
      token = OAuth::RequestToken.new(client, oauth.token, oauth.secret)
      token.get_access_token(oauth_verifier: oauth_verifier)
    end

    def jwt_by_oauth token
      jwt_for token.user_id, token.handle
    end

    def jwt_for uid, login
      JWT.encode(
        { uid: uid, login: login, exp: 1.day.from_now.to_i },
        Rails.application.secrets.secret_key_base
      )
    end

    def register_by_oauth access_token
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

    def register_directly email, pwd
      User.create_with_direct_auth(email, pwd)
    end

    def login_by_password auth
      jwt_for auth.id, auth.email
    end

    def oauth_handler_for provider
      case provider
      when "twitter"
        OauthProviders::Twitter
      end
    end

    def login_with_jwt secret
      begin
        id = JWT.decode(secret, Rails.application.secrets.secret_key_base)[0]['uid']
        User.where(id: id).first
      rescue JWT::DecodeError
        nil
      end

    end
  end

end
