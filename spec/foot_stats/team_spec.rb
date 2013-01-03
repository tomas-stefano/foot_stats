# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Team do
    describe '.all' do
      context "normal response" do
        use_vcr_cassette 'championship_teams'

        subject { Team.all(championship: 198).first }

        its(:source_id)     { should eq 1487 }
        its(:full_name)   { should eq 'América (Teófilo Otoni)' }
        its(:city) { should eq 'Teófilo Otoni' }
        its(:country)   { should eq 'Brasil'}
      end

      context "error response" do
        use_vcr_cassette 'championship_teams_error_response'
        subject { Team.all(championship: 198) }

        its(:message) { should eq 'Usuário ou senha Inválidos' }
      end
    end

    describe ".resource_name" do
      subject { Team }

      its(:resource_name) { should eq 'ListaEquipesCampeonato' }
    end

    describe ".resource_key" do
      subject { Team }

      its(:resource_key) { should eq 'Equipe' }
    end
  end
end