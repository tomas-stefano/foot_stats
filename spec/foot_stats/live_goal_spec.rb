require 'spec_helper'

module FootStats
  class Live
    describe Goal do
      let(:team) do
        mock(players: [
          Live::Player.new({ "@IdJogador" => '1234', "@Jogador" => 'Fred' }),
          Live::Player.new({ "@IdJogador" => '12345', "@Jogador" => 'Oscar' })
        ])
      end

      describe '#==' do
        let(:live_goal) do
          Goal.new({
            "@Jogador" => "Fred",
            "@Periodo" => "Primeiro tempo",
            "@Minuto"  => "20",
            "@Tipo"    => "Favor"
          }, team)
        end

        context 'when equal' do
          let(:goal_fixture) do
            GoalFixture.new({
              player_source_id: "1234",
              period:      "Primeiro tempo",
              minute:      20,
              type:        "Favor"
            })
          end
          subject { live_goal == goal_fixture }

          it { should be true }
        end

        context 'when different' do
          let(:goal_fixture) do
            GoalFixture.new({
              player_source_id: "12345",
              period:      "Primeiro tempo",
              minute:      20,
              type:   "Favor"
            })
          end
          subject { live_goal == goal_fixture }

          it { should be false }
        end
      end

      describe 'include?' do
        let(:first_goal) do
          GoalFixture.new({
            player_source_id: "1234",
            period: "Primeiro tempo",
            minute: 20,
            type:   "Favor"
          })
        end

        let(:second_goal) do
          GoalFixture.new({
            player_source_id: "12345",
            period:      "Segundo tempo",
            minute:      20,
            type:        "Favor"
          })
        end

        let(:third_goal) do
          GoalFixture.new({
            player_source_id: "12345",
            period:      "Primeiro tempo",
            minute:      1,
            type:        "Favor"
          })
        end

        let(:goals) do
          [
            Goal.new({
              "@Jogador" => "Fred",
              "@Periodo" => "Primeiro tempo",
              "@Minuto"  => "20",
              "@Tipo"    => "Favor"
            }, team),
            Goal.new({
              "@Jogador" => "Oscar",
              "@Periodo" => "Segundo tempo",
              "@Minuto"  => "20",
              "@Tipo"    => "Favor"
            }, team)
          ]
        end

        context 'when is included' do
          subject { goals.include?(first_goal) }

          it { should be true }
        end

        context 'when is not included' do
          subject { goals.include?(third_goal) }

          it { should be false }
        end
      end
    end

    class GoalFixture
      attr_accessor :minute, :player_source_id, :period, :type

      def initialize(options)
        options.each { |key, value| send("#{key}=", value) }
      end
    end
  end
end