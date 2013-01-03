require 'active_support/json'

module FootStats
  class Response
    attr_accessor :resource_key, :body, :parsed_response
    REGEX_PARSER = /\{.*}/m

    def initialize(options={})
      @resource_key    = options.fetch(:resource_key)
      @body            = options.fetch(:body)
      @parsed_response = ActiveSupport::JSON.decode(json_response)
    end

    # Return the error response object with the message if had errors.
    #
    # @return [ErrorResponse]
    #
    def error
      ErrorResponse.new(@parsed_response['Erro']['@Mensagem']) if error?
    end

    # Verifies if the response had errors.
    #
    # @return [True, False]
    #
    def error?
      @parsed_response['Erro'].present?
    end

    # Return the resource match by the resource key.
    #
    # @return [Hash]
    #
    def resource
      @parsed_response[@resource_key]
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

    def json_response
      @body.scan(REGEX_PARSER).first
    end
  end
end