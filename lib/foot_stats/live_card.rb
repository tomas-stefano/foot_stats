module FootStats
  class Live < Resource
    class Card
      attr_reader :player_name, :period, :minute, :type

      def initialize(params)
        @player_name = params['@Jogador']
        @period      = params['@Periodo']
        @minute      = params['@Minuto'].to_i
        @type        = params['@Tipo']
      end
    end
  end
end