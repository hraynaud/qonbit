uri = URI.parse(ENV["REDIS_URL"] || "redis://127.0.0.1:6379")
$REDIS_SERVER =  Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
