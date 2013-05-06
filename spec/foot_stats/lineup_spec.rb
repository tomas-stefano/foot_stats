require 'spec_helper'

module FootStats
  describe Lineup do
    describe '#==' do
      let(:fred)  { mock('Player', source_id: '1234', name: 'Fred') }
      let(:oscar) { mock('Player', source_id: '12345', name: 'Oscar') }
      let(:lineup) { Lineup.new([fred]) }

      context 'when is equal' do
        let(:lineup_fixture) { LineupFixture.new([fred]) }
        subject { lineup == lineup_fixture }

        it { should be true }
      end

      context 'when is different' do
        let(:lineup_fixture) { LineupFixture.new([oscar]) }
        subject { lineup == lineup_fixture }

        it { should be false }
      end
    end

    class LineupFixture < Array
    end
  end
end