module FootStats
  class Response
    attr_accessor :resource_key, :body, :parsed_response, :payload
    REGEX_PARSER = /\{.*}/m

    def initialize(options={})
      @resource_key    = options.fetch(:resource_key)
      @body            = options.fetch(:body)
      @stream_key      = options[:stream_key]
      @parsed_response = JSON.parse(json_response)
      check_stream
    end

    # Mark response as readed, storing payload at payload store
    def readed
      if @stream_key
        stream.store @payload
      else
        true
      end
    end

    # Return the error response object with the message if had errors.
    #
    # @return [ErrorResponse]
    #
    def error
      ErrorResponse.new(@parsed_response['Erro']['@Mensagem']) if error?
    end

    # Verifies if response is up-to-date
    #
    # @return [Boolean]
    #
    def updated?
      if @stream_key
        stream.updated?(@payload)
      else
        true
      end
    end

    # Verifies if the response had errors.
    #
    # @return [True, False]
    #
    def error?
      @parsed_response['Erro'] != nil
    end

    # Return the resource match by the resource key.
    #
    # @return [Hash]
    #
    def resource
      if @resource_key
        @parsed_response[@resource_key]
      else
        @parsed_response
      end
    end

    # Attempt to fetch a key from resource.
    #
    # @return [Object]
    #
    def [](value)
      resource[value]
    end

    # Collect all the resources evaluate from FootStats
    #
    # @return [Array]
    #
    def collect
      resource.collect { |resource_value| yield(resource_value) }
    end
    alias :map :collect

    private
    def stream
      @stream ||= Stream.new(@stream_key)
    end

    def check_stream
      if @stream_key
        @payload = Digest::MD5.hexdigest @body
      else
        @payload = nil
      end
    end

    def json_response
      @body.scan(REGEX_PARSER).first
    end
  end
end