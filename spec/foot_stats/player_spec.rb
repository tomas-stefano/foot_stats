# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Player do
    describe '.all' do
      context "normal response" do
        use_vcr_cassette 'team_player'

        subject { Player.all(team: 1487) }

        it 'should have a lot of players' do
          subject.count.should == 37
          subject.each do |player|
            player.should           be_a(FootStats::Player)
            player.source_id.should be_a(Integer)
            player.full_name.should be_a(String)
            player.nickname.should  be_a(String)
          end
        end
      end
    end

    describe ".resource_name" do
      subject { Player }
      its(:resource_name) { should eq 'ListaJogadoresEquipe' }
    end

    describe ".resource_key" do
      subject { Player }
      its(:resource_key) { should eq 'Jogador' }
    end
  end
end