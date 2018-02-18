require 'related'
 Related.redis = Redis::Namespace.new(":related_#{Rails.env}", redis: $REDIS_SERVER)
