module FootStats
  class Championship < Resource
    attr_accessor :source_id, :name, :has_classification, :current_round, :total_rounds

    # Retrieve all championships from FootStats
    #
    # @return [Array]
    #
    def self.all
      request  = Request.new(self)
      response = request.parse

      return response.error if response.error?

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
    def classification
      ChampionshipClassification.all(championship: source_id)
    end

    # Return the Championship teams.
    #
    # @return [Array]
    #
    def teams
      Team.all(championship: source_id)
    end

    # Return all the Championship matches.
    #
    # @return [Array]
    #
    def matches
      Match.all(championship: source_id)
    end
  end
end