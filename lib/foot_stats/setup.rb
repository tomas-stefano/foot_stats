require 'active_support/core_ext/class'

module FootStats
  # Class responsible to handle all the FootStats setup.
  #
  # @example
  #
  #    FootStats::Setup.setup do |config|
  #      config.username = "foo"
  #      config.password = "bar"
  #      config.logger   = Rails.logger
  #      config.base_url = "http://footstats.com.br/modyo.asmx/"
  #    end
  #
  class Setup
    cattr_accessor :username
    cattr_accessor :password
    cattr_accessor :logger
    cattr_accessor :base_url
    cattr_accessor :payload_store

    # @param block [Proc]
    #
    def self.setup
      self.payload_store = Hash.new
      yield(self) if block_given?
    end
  end
end