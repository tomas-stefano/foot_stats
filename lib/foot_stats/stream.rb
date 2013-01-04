module FootStats
  class Stream
    attr_reader :key

    def initialize(key)
      @key = key
    end

    # Verifies if payload is up-to-date
    #
    # @return [String]
    #
    def updated?(new_payload)
      new_payload == payload
    end

    protected

    # TODO: Needs to implement a decent key-store to persist payloads
    def payload
      @@payloads ||= {}
      @@payloads[@key]
    end
  end
end