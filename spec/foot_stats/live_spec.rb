# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Live do
    describe ".find" do
      context "normal response" do
        use_vcr_cassette 'live_match'

        subject { Live.find 25563 }

        its(:source_id)     { should == 25563                   }
        its(:date)          { should == '2/9/2011 6:00:00 PM'   }
        its(:score)         { should == { home: 1, visitor: 0 } }
        its(:penalty_score) { should == { home: 0, visitor: 0 } }
        its(:period)        { should == 'Partida encerrada'     }
        its(:referee)       { should == 'Wolfgang Stark'        }
        its(:stadium)       { should == 'Stade de France'       }
        its(:city)          { should == 'Paris'                 }
        its(:country)       { should == 'França'                }
        its(:narration?)    { should be true                    }
        its(:round)         { should == 1                       }
        its(:phase)         { should == 'Primeira Fase'         }
        its(:cup)           { should == ''                      }
        its(:group)         { should == ''                      }
        its(:response)      { should include %{"@IdPartida": "25563"} }

        it 'should have 11 initial players per team' do
          subject.home_team.initial_players.count.should    == 11
          subject.home_team.initial_players.should be_a(FootStats::Lineup)
          subject.visitor_team.initial_players.count.should == 11
          subject.visitor_team.initial_players.should be_a(FootStats::Lineup)
        end

        it 'should have 4 substituted players per team' do
          subject.home_team.substituted_players.count.should    == 4
          subject.home_team.substituted_players.should be_a(FootStats::Lineup)
          subject.visitor_team.substituted_players.count.should == 4
          subject.visitor_team.substituted_players.should be_a(FootStats::Lineup)
        end

        it 'should have players for the team' do
          subject.home_team.players.should be_a(FootStats::Lineup)
          subject.visitor_team.players.should be_a(FootStats::Lineup)
        end

        it 'should have correct goals count per team' do
          subject.home_team.goals.count.should    == subject.home_score
          subject.visitor_team.goals.count.should == subject.visitor_score
        end

        it 'should have some cards per team' do
          subject.home_team.cards.count.should    == 1
          subject.visitor_team.cards.count.should == 2
        end

        it 'should return all goals from visitor team and home team' do
          subject.goals.should eq [subject.home_team.goals.first]
          goal = subject.home_team.goals.first
          goal.minute.should be 8
          goal.period.should eq 'Segundo tempo'
          goal.player_name.should eq 'Karim Benzema'
          goal.player_source_id.should be 17158
          goal.team_name.should eq 'França'
          goal.team_source_id.should eq '1105'
        end
      end

      context 'internal server error response' do
        use_vcr_cassette 'internal_server_error'
        subject { Live.find 255639012901019 }

        it { should be_a ErrorResponse }
        its(:message) { should eq '500 Internal Server Error' }
      end

      context 'simulate response' do
        subject { Live.find(25563, response: Response.new({ body: %{
          <string xmlns="http://tempuri.org/">
            {"Erro": {"@Mensagem": "Usuário ou senha Inválidos"}}
          </string>
        } })) }

        it { should be_a ErrorResponse }
      end
    end

    describe ".resource_name" do
      subject { Live }
      its(:resource_name) { should == 'AoVivo' }
    end

    describe ".resource_key" do
      subject { Live }
      its(:resource_key) { should be_nil }
    end
  end
end