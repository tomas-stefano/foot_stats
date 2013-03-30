module FootStats
  class Resource
    include AttributeAccessor

    # Waiting for ActiveModel::Model. =p
    #
    def initialize(options={})
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end

    # Return parsed response if updated when requested updated data
    #
    # @return [Array]
    #
    def self.updated_response(response, options)
      parsed_response = if options[:updated]
        if response.updated?
          response.readed
          parse_response response
        else
          []
        end
      else
        parse_response(response)
      end

      if parsed_response.is_a?(Array)
        CollectionResource.new(parsed_response, response)
      else
        parsed_response.response = response.body
        parsed_response
      end
    end

    # Return response parsed data
    #
    # @return [String]
    #
    def self.parse_response(response)
      raise NotImplementedError, "need to implement .parse_response in #{self}."
    end

    # Return the resource name to request to FootStats.
    #
    # @return [String]
    #
    def self.resource_name
      raise NotImplementedError, "need to implement .resource_name in #{self}."
    end

    # Return the resource key that is fetch from the API response.
    #
    # @return [String]
    #
    def self.resource_key
      raise NotImplementedError, "need to implement .resource_key in #{self}."
    end
  end

  class CollectionResource < Array
    attr_reader :response

    def initialize(parsed_response, response)
      @response = response.body

      super(parsed_response)
    end
  end
end