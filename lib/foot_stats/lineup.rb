module FootStats
  class Lineup < Array
    def ==(array)
      collect { |player| player.source_id.to_s } == array.collect { |player| player.source_id.to_s }
    end
  end
end