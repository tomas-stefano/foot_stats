module FootStats
  class Live < Resource
    class Goal
      attr_reader :player_name, :period, :minute, :type

      def initialize(params, team)
        @player_name = params['@Jogador']
        @period      = params['@Periodo']
        @minute      = params['@Minuto'].to_i
        @type        = params['@Tipo']
        @team        = team
      end

      def ==(goal)
        minute == goal.minute and period == goal.period and player_source_id.to_s == goal.player_source_id.to_s and type == goal.type
      end

      def team_name
        @team.full_name
      end

      def team_source_id
        @team.source_id
      end

      def player_source_id
        @team.players.find { |player| player.name == player_name }.source_id
      end
    end
  end
end