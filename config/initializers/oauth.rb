TWITTER_OAUTH = OAuth::Consumer.new(
  Rails.application.secrets.twitter_consumer_key,
  Rails.application.secrets.twitter_consumer_secret,
  authorize_path: '/oauth/authenticate',
  site: 'https://api.twitter.com'
)

TWITTER_OAUTH_CALLBACK = ENV['TWITTER_OAUTH_CALLBACK']

