module FootStats
  class RoundMatch < FootStats::Match
    def self.all(options={})
      championship_id = options.fetch(:championship)
      round           = options.fetch(:round)

      request  = Request.new self, :Campeonato => championship_id, :Rodada => round
      response = request.parse stream_key: "championship-#{championship_id}-round-matches-#{round}"

      return response.error if response.error?

      updated_response response, options
    end

    # Return the resource name to request to FootStats.
    #
    # @return [String]
    #
    def self.resource_name
      'ListaPartidasRodada'
    end
  end
end