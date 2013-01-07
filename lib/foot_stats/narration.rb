module FootStats
  class Narration < Resource
    attr_accessor :championship_id, :name, :season, :match_id, :score, :has_penalty, :details

    def self.all(options={})
      match_id = options.fetch(:match)
      request  = Request.new self, :Partida => match_id
      response = request.parse stream_key: "match-narration-#{match_id}"

      return response.error if response.error?

      updated_response response, options
    end

    def self.parse_response(response)
      response.collect do |match, value|
        match_hash = response['Partida']
        narrations = response['Narracoes'] || []

        narration = Narration.new(
          :championship_id => response['@Id'].to_i,
          :name            => response['@Nome'],
          :season          => response['@Temporada'],
          :match_id        => match_hash['@Id'].to_i,
          :score           => match_hash['@Placar'],
          :has_penalty     => match_hash['@TemDisputaPenaltis']
        )

        if narrations.empty?
          narration.details = narrations
        else
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
        end

        narration
      end
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