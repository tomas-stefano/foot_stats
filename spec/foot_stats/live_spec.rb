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
        its(:narration?)    { should be_true                    }
        its(:round)         { should == 1                       }
        its(:phase)         { should == 'Primeira Fase'         }
        its(:cup)           { should == ''                      }
        its(:group)         { should == ''                      }

        it 'should have 11 initial players per team' do
          subject.home_team.initial_players.count.should    == 11
          subject.visitor_team.initial_players.count.should == 11
        end

        it 'should have 4 substituted players per team' do
          subject.home_team.substituted_players.count.should    == 4
          subject.visitor_team.substituted_players.count.should == 4
        end

        it 'should have correct goals count per team' do
          subject.home_team.goals.count.should    == subject.home_score
          subject.visitor_team.goals.count.should == subject.visitor_score
        end

        it 'should have some cards per team' do
          subject.home_team.cards.count.should    == 1
          subject.visitor_team.cards.count.should == 2
        end
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