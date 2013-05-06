module FootStats
  class Lineup < Array
    def ==(array)
      collect { |player| player.source_id } == array.collect { |player| player.source_id }
    end
  end
end