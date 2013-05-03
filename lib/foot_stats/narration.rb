module FootStats
  class Narration < Resource
    attr_accessor :championship_id, :name, :season, :match_id, :score, :has_penalty, :details, :response

    def self.all(options={})
      [self.find(options)]
    end

    # Retrieve narration data of a match.
    #
    # <b>If you want simulate just pass the response instance in :response options.</b>
    #
    # @example
    #
    #     FootStats::Narration.find(match: 25563)
    #     # => #<Narration:128909190198>
    #
    #     # Simulate the request
    #     #
    #     FootStats::Narration.find(match: 25563, response: Response.new({ body: '...' }))
    #     # => #<Narration:128909171653>
    #
    # @argument <Integer>
    # @argument options <Hash>
    # @options match <String> the source id from a match in Footstats.
    # @option response <FootStats::Response> Simulate an Response
    #
    # @return [Narration]
    #
    def self.find(options={})
      match_id = options.fetch(:match)
      response = options[:response] || Request.new(self, :Partida => match_id).parse(stream_key: "match_narration-#{match_id}")

      return response.error if response.error?

      updated_response response, options
    end

    def self.parse_response(response)
      match_hash = response['Partida']
      # Yeah... FootStats bizarre collection made me do it!
      narrations = [(response['Narracoes'] || {})['Narracao']].flatten.compact

      narration = Narration.new(
        :championship_id => response['@Id'].to_i,
        :name            => response['@Nome'],
        :season          => response['@Temporada'],
        :match_id        => match_hash['@Id'].to_i,
        :score           => match_hash['@Placar'],
        :has_penalty     => match_hash['@TemDisputaPenaltis']
      )

      narration.details = []
      narrations.each do |foot_stats_narration|
        narration.details.push(NarrationDetail.new(
          :source_id        => foot_stats_narration["@Id"].to_i,
          :team_source_id   => foot_stats_narration["IdEquipe"].to_i,
          :team_name        => foot_stats_narration["NomeEquipe"],
          :player_source_id => foot_stats_narration["IdJogador"].to_i,
          :player_name      => foot_stats_narration["NomeJogador"],
          :period           => foot_stats_narration["Periodo"],
          :moment           => foot_stats_narration["Momento"],
          :description      => foot_stats_narration["Descricao"],
          :action           => foot_stats_narration["Acao"]
        ))
      end
      narration
    end

    # Return the resource name to request to FootStats.
    #
    # @return [String]
    #
    def self.resource_name
      'Narracao'
    end

    # Return the resource key that is fetch from the API response.
    #
    # @return [String]
    #
    def self.resource_key
      'Campeonato'
    end
  end

  class NarrationDetail < Resource
    attr_accessor :source_id, :team_source_id, :team_name, :player_source_id
    attr_accessor :player_name, :period, :moment, :description, :action
  end
end