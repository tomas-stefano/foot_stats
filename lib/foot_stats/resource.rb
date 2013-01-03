module FootStats
  class Resource
    # Waiting for ActiveModel::Model. =p
    #
    def initialize(options={})
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
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
end