module FootStats
  class Team < Resource
    attr_accessor :source_id, :full_name, :city, :country

    def self.all(options={})
      championship_id = options.fetch(:championship)

      request = Request.new(self,
        :IdCampeonato => options.fetch(:championship),
        :stream_key   => "team-championship-#{championship_id}")

      response = request.parse

      return response.error if response.error?

      updated_response response, options
    end

    def self.parse_response(response)
      response.collect do |team|
        Team.new(
          :source_id => team['@Id'].to_i,
          :full_name => team['@Nome'],
          :city      => team['@Cidade'],
          :country   => team['@Pais']
        )
      end
    end

    # Return the resource name to request to FootStats.
    #
    # @return [String]
    #
    def self.resource_name
      'ListaEquipesCampeonato'
    end

    # Return the resource key that is fetch from the API response.
    #
    # @return [String]
    #
    def self.resource_key
      'Equipe'
    end
  end
end