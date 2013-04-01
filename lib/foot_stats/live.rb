module FootStats
  class Live < Resource
    attr_accessor :response

    autoload :Card,   'foot_stats/live_card'
    autoload :Goal,   'foot_stats/live_goal'
    autoload :Player, 'foot_stats/live_player'
    autoload :Team,   'foot_stats/live_team'

    MAPPED_PARAMS = {
      source_id:     '@IdPartida',
      score:         '@Placar',
      penalty_score: '@PlacarPenaltis',
      date:          '@Data',
      period:        '@Periodo',
      referee:       '@Arbitro',
      stadium:       '@Estadio',
      city:          '@Cidade',
      country:       '@Pais',
      has_narration: '@TemNarracao',
      round:         '@Rodada',
      phase:         '@Fase',
      cup:           '@Taca',
      group:         '@Grupo',
      home_team:     'Mandante',
      visitor_team:  'Visitante'
    }

    attr_accessor *MAPPED_PARAMS.keys

    alias :narration? :has_narration

    def home_score
      score[:home]
    end

    def visitor_score
      score[:visitor]
    end

    def home_penalty_score
      penalty_score[:home]
    end

    def visitor_penalty_score
      penalty_score[:visitor]
    end

    def goals
      [home_team.goals, visitor_team.goals].flatten
    end

    alias :narration? :has_narration

    class << self
      # Retrieve live data of a match
      #
      # @return [Live]
      #
      def find(match_id, options={})
        response = Request.new(self, :IdPartida => match_id).parse stream_key: 'live_match'
        return response.error if response.error?

        updated_response response, options
      end

      # Return the resource name to request to FootStats.
      #
      # @return [String]
      #
      def resource_name
        'AoVivo'
      end

      # Return the resource key that is fetch from the API response.
      #
      # @return [String]
      #
      def resource_key
        nil
      end

      protected
      def parse_response(response)
        live_params = Hash.new

        MAPPED_PARAMS.each do |key, foot_stats_key|
          setter_method = :"parse_#{key}"
          if respond_to? setter_method
            live_params[key] = send(setter_method, response[foot_stats_key], response)
          else
            live_params[key] = response[foot_stats_key]
          end
        end

        self.new live_params
      end

      def parse_int(value, payload)
        value.to_i
      end
      alias :parse_source_id :parse_int
      alias :parse_round     :parse_int

      def parse_score(score, payload)
        home_score, visitor_score = score.split '-'
        {
          home:    (home_score || 0).to_i,
          visitor: (visitor_score || 0).to_i
        }
      end
      alias :parse_penalty_score :parse_score

      def parse_has_narration(narration, payload)
        narration == 'Sim'
      end

      def parse_team(team_params, payload)
        Team.new(team_params, payload)
      end
      alias :parse_home_team    :parse_team
      alias :parse_visitor_team :parse_team
    end
  end
end