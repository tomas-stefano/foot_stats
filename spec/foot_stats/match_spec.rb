# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Match do
    describe ".all" do
      context "normal response" do
        use_vcr_cassette 'championship_match'
        let(:matches) { Match.all(championship: 198) }
        subject { matches.first }

        it { matches.response.should include %{{"@Id":"1077","@Nome":"Caldense","@Placar":" ","@PlacarPenaltis":"","@Tipo":"Mandante"}} }

        its(:source_id)     { should eq 34829 }
        its(:date)          { should eq '29/1/2012 4:00:00 PM' }
        its(:status)        { should eq 'Partida não iniciada' }
        its(:referee)       { should eq '0' }
        its(:stadium)       { should eq 'Ronaldo Junqueira' }
        its(:city)          { should eq 'Poços de Caldas' }
        its(:state)         { should eq 'MG' }
        its(:country)       { should eq 'Brasil' }
        its(:has_statistic) { should eq 'Não' }
        its(:has_narration) { should eq 'Não' }
        its(:round)         { should eq '1' }
        its(:phase)         { should eq 'Primeira Fase' }
        its(:cup)           { should eq '9' }
        its(:group)         { should eq '3' }
        its(:game_number)   { should eq '100' }
        its(:live?)         { should be_false }

        its(:home_team)      { should eq 1077 }
        its(:home_team_name) { should eq 'Caldense' }
        its(:home_score)     { should eq ' ' }
        its(:home_penalties_score) { should eq '' }

        its(:visitor_team)      { should eq 1242 }
        its(:visitor_team_name) { should eq 'Tupi' }
        its(:visitor_score)     { should eq ' ' }
        its(:visitor_penalties_score) { should eq '' }

        its(:description) { should eq 'Caldense X Tupi' }
      end

      context "error response" do
        use_vcr_cassette 'championship_match_error_response'
        subject { Match.all(championship: 198) }

        its(:message) { should eq 'Usuário ou senha Inválidos' }
      end
    end

    describe ".resource_name" do
      subject { Match }

      its(:resource_name) { should eq 'ListaPartidas' }
    end

    describe ".resource_key" do
      subject { Match }

      its(:resource_key) { should eq 'Partidas' }
    end

    describe "#narrations" do
      it 'should call all from championship passing the id' do
        Narration.should_receive(:all).with(match: 12)
        Match.new(source_id: 12).narrations
      end
    end
  end
end