module FootStats
  class Live < Resource
    class Player
      attr_reader :source_id, :name, :status, :was_substituted, :substituted, :period, :minute

      def initialize(params)
        @source_id       = params["@IdJogador"].to_i
        @name            = params["@Jogador"]
        @status          = params["@Status"]
        @was_substituted = params["@Substituto"] != ''
        @period          = params["@Periodo"]
        @minute          = params["@Minuto"].to_i

        @substituted = params["@Substituto"] if @was_substituted
      end

      alias :substituted? :was_substituted

      def self.diff(players, old_players_ids)
        new_players_ids = players.map &:source_id
        {
          added:   (new_players_ids - old_players_ids),
          removed: (old_players_ids - new_players_ids)
        }
      end
    end
  end
end