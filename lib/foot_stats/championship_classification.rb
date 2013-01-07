module FootStats
  class ChampionshipClassification < Resource
    attr_accessor :team_source_id, :group, :position, :points, :games, :victories, :draws, :loss
    attr_accessor :goals_for, :goals_against, :goals_balance, :home_victories, :outside_victories
    attr_accessor :home_draws, :outside_draws, :home_defeats, :outside_defeats, :max_point
    attr_accessor :use

    def self.all(options={})
      championship_id = options.fetch(:championship)
      request  = Request.new self, :Campeonato => championship_id
      response = request.parse stream_key: "championship-classification-#{championship_id}"

      return response.error if response.error?

      updated_response response, options
    end

    def self.parse_response(response)
      response["Classificacoes"]['Classificacao']['Equipe'].collect do |classification|
        ChampionshipClassification.new(
          :team_source_id    => classification['@Id'].to_i,
          :group             => classification['@Grupo'],
          :position          => classification['Posicao'],
          :points            => classification['Pontos_Ganhos'],
          :games             => classification['Jogos'],
          :victories         => classification['Vitorias'],
          :draws             => classification['Empates'],
          :loss              => classification['Derrotas'],
          :goals_for         => classification['Gols_Pro'],
          :goals_against     => classification['Gols_Contra'],
          :goals_balance     => classification['Saldo_Gols'],
          :home_victories    => classification['Vitorias_Casa'],
          :outside_victories => classification['Vitorias_Fora'],
          :home_draws        => classification['Empates_Casa'],
          :outside_draws     => classification['Empate_Fora'],
          :home_defeats      => classification['Derrotas_Casa'],
          :outside_defeats   => classification['Derrotas_Fora'],
          :max_point         => classification['Ponto_Maximo'],
          :use               => classification['Aproveitamento']
        )
      end
    end

    # Return the resource name to request to FootStats.
    #
    # @return [String]
    #
    def self.resource_name
      'ListaClassificacao'
    end

    # Return the resource key that is fetch from the API response.
    #
    # @return [String]
    #
    def self.resource_key
      'Campeonato'
    end
  end
end