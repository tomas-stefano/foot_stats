# encoding: utf-8
require 'spec_helper'

module FootStats
  describe ChampionshipClassification do
    describe '.all' do
      context "normal response" do
        use_vcr_cassette 'championship_classification'

        subject { ChampionshipClassification.all(championship: 198).first }

        its(:team_source_id) { should eq 1487 }
        its(:group)          { should eq '' }
        its(:position)       { should eq '1' }
        its(:points)         { should eq '30' }
        its(:games)          { should eq '10' }
        its(:victories)      { should eq '10' }
        its(:draws)          { should eq '0' }
        its(:loss)           { should eq '0' }
        its(:goals_for)      { should eq '23' }
        its(:goals_against)  { should eq '9' }
        its(:goals_balance)  { should eq '14' }
        its(:home_victories) { should eq '5' }
        its(:outside_victories) { should eq '5' }
        its(:home_draws)        { should eq '0' }
        its(:outside_draws)     { should eq '0' }
        its(:home_defeats)      { should eq '0' }
        its(:outside_defeats)   { should eq '0' }
        its(:max_point)   { should eq '33' }
        its(:use) { should eq '' }
      end

      context "error response" do
        use_vcr_cassette 'championship_classification_error_response'
        subject { ChampionshipClassification.all(championship: 198) }

        its(:message) { should eq 'Usuário ou senha Inválidos' }
      end
    end

    describe ".resource_name" do
      subject { ChampionshipClassification }

      its(:resource_name) { should eq 'ListaClassificacao' }
    end

    describe ".resource_key" do
      subject { ChampionshipClassification }

      its(:resource_key) { should eq 'Campeonato' }
    end
  end
end