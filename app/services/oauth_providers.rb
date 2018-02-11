module OauthProviders
  class BaseOAuth

    class << self
      def login
        request_token = client.get_request_token(call_back_hash)
        store_token request_token, name
        request_token.authorize_url(call_back_hash)
      end

      def store_token request_token, provider
        Oauth.find_or_create_by(token: request_token.token, secret: request_token.secret, provider: provider)
      end
    end

  end

  class Twitter < BaseOAuth
    class << self
      def client
        TWITTER_OAUTH
      end

      def call_back_hash
        {oauth_callback: TWITTER_OAUTH_CALLBACK}
      end

      def name
        "twitter"
      end

    end
  end
end
