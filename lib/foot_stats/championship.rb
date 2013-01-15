module FootStats
  class Championship < Resource
    attribute_accessor :source_id, :name, :has_classification, :current_round, :total_rounds

    # Retrieve all championships from FootStats
    #
    # @return [Array]
    #
    def self.all(options = {})
      response = Request.new(self).parse stream_key: 'championships'

      return response.error if response.error?

      updated_response response, options
    end

    def self.parse_response(response)
      response.collect do |championship|
        new(
          :source_id          => championship['@Id'].to_i,
          :name               => championship['@Nome'],
          :has_classification => championship['@TemClassificacao'] == 'True',
          :current_round      => championship['@RodadaATual'].to_i,
          :total_rounds       => championship['@Rodadas'].to_i
        )
      end
    end

    # Return the resource name to request to FootStats.
    #
    # @return [String]
    #
    def self.resource_name
      'ListaCampeonatos'
    end

    # Return the resource key that is fetch from the API response.
    #
    # @return [String]
    #
    def self.resource_key
      'Campeonato'
    end

    # Return the Championship classification.
    #
    # @return [Array]
    #
    def classification(options = {})
      ChampionshipClassification.all(options.merge(championship: source_id))
    end

    # Return the Championship teams.
    #
    # @return [Array]
    #
    def teams(options = {})
      Team.all(options.merge(championship: source_id))
    end

    # Return all the Championship matches.
    #
    # @return [Array]
    #
    def matches(options = {})
      Match.all(options.merge(championship: source_id))
    end
  end
end