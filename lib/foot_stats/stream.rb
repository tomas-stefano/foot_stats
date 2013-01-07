module FootStats
  class Stream
    attr_reader :key

    def initialize(key)
      @key = key
    end

    # Stores latest payload
    def store(value)
      payload_store[@key] = value
    end

    # Verifies if payload is up-to-date
    #
    # @return [String]
    #
    def updated?(new_payload)
      payload != new_payload
    end

    # Access payload store
    def payload
      payload_store[@key]
    end

    protected
    def payload_store
      FootStats::Setup.payload_store
    end
  end
end