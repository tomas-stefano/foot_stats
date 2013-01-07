module FootStats
  # Class responsible to handle all the FootStats setup.
  #
  # @example
  #
  #    FootStats::Setup.setup do |config|
  #      config.username      = "foo"
  #      config.password      = "bar"
  #      config.logger        = Rails.logger
  #      config.base_url      = "http://footstats.com.br/modyo.asmx/"
  #      config.payload_store = Redis.new
  #    end
  #
  class Setup
    attr_accessor :username, :password, :logger, :base_url, :payload_store

    include Singleton

    # @param block [Proc]
    #
    def self.setup
      instance.payload_store = Hash.new
      yield(instance) if block_given?
    end

    def self.method_missing(method_name, *args, &block)
      instance.send method_name, *args, &block
    end
  end
end