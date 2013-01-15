module FootStats
  class Player < Resource
    attribute_accessor :source_id, :full_name, :nickname

    def self.all(options={})
      team_id = options.fetch(:team)
      request  = Request.new self, :Equipe => team_id
      response = request.parse stream_key: "team_players-#{team_id}"

      return response.error if response.error?

      updated_response response, options
    end

    def self.parse_response(response)
      # FootStats sucks!
      # When there is only one player, resource isn't a collection,
      # but it's the only player!
      case response.resource
      when Hash
        [self.new(
          source_id: response.resource['@Id'].to_i,
          full_name: response.resource['@Nome'],
          nickname:  response.resource['@Apelido']
        )]
      when Array
        response.collect do |player_params|
          self.new(
            source_id: player_params['@Id'].to_i,
            full_name: player_params['@Nome'],
            nickname:  player_params['@Apelido']
          )
        end
      else
        []
      end
    end

    # Return the resource name to request to FootStats.
    #
    # @return [String]
    #
    def self.resource_name
      'ListaJogadoresEquipe'
    end

    # Return the resource key that is fetch from the API response.
    #
    # @return [String]
    #
    def self.resource_key
      'Jogador'
    end
  end
end