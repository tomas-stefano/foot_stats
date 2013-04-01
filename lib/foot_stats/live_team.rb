module FootStats
  class Live < Resource
    class Team
      attr_reader :coach, :full_name, :source_id, :name
      attr_reader :cards, :players, :goals

      def initialize(params)
        @coach     = params['@Tecnico']
        @full_name = params['@Nome']
        @source_id = params['@Id']

        parse_cards   params['Cartoes']
        parse_goals   params['Gols']
        parse_players params['Escalacao']
      end

      def initial_players
        players.find_all{ |player| !player.substituted? }
      end

      def substituted_players
        players.find_all{ |player| player.substituted? }
      end

      protected
      def fix_collection(collection, key)
        return [] if collection.nil?

        if collection[key].is_a? Array
          collection[key]
        else
          [ collection[key] ]
        end
      end

      def parse_goals(goals)
        @goals = fix_collection(goals, 'Gol').map do |goal_params|
          Goal.new(goal_params, self)
        end
      end

      def parse_cards(cards)
        @cards = fix_collection(cards, 'Cartoes').map do |card_params|
          Card.new card_params
        end
      end

      def parse_players(players)
        @players = fix_collection(players, 'Jogador').map do |player_params|
          Player.new player_params
        end
      end
    end
  end
end