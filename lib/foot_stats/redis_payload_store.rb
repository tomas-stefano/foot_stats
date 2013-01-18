module FootStats
  class RedisPayloadStore
    def initialize(redis_config)
      @redis = setup_redis(redis_config)
    end

    def [](key)
      @redis[key]
    end

    def []=(key, value)
      @redis[key] = value
      if key.to_s.match(/^match_narration/) || key.to_s.match(/^live_match/) || key.to_s.match(/^match_championship/)
        @redis.expire key, 1.month
      end
      value
    end

    protected
    def setup_redis(redis_config)
      case redis_config
      when String
        if redis_config['redis://']
          redis = Redis.connect(url: redis_config, thread_safe: true)
        else
          redis_config, namespace = redis_config.split('/', 2)
          host, port, db          = redis_config.split(':')
          redis = Redis.new(host: host, port: port, thread_safe: true, db: db)
        end
        namespace ||= :foot_stats

        Redis::Namespace.new(namespace, :redis => redis)
      when Redis::Namespace
        redis_config
      else
        Redis::Namespace.new(:foot_stats, :redis => redis_config)
      end
    end
  end
end