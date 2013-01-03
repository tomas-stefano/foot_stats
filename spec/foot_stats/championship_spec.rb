# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Championship do
    describe '.all' do
      context "normal response" do
        use_vcr_cassette 'championship'
        subject { Championship.all.first }

        its(:source_id)   { should be 172 }
        its(:name) { should eq 'Camp. Paulista 2012' }
        its(:has_classification) { should be true }
        its(:current_round)      { should be 1 }
        its(:total_rounds)           { should be 18 }
      end

      context "error response" do
        use_vcr_cassette 'error_response'
        subject { Championship.all }

        its(:message) { should eq 'Usuário ou senha Inválidos' }
      end
    end

    describe "#source_id" do
      subject { Championship.new(source_id: 71) }

      its(:source_id) { should be 71 }
    end

    describe "#name" do
      subject { Championship.new(name: 'Campeonato Carioca') }

      its(:name) { should eq 'Campeonato Carioca' }
    end

    describe "#has_classification" do
      subject { Championship.new(has_classification: false) }

      its(:has_classification) { should be false }
    end

    describe "#current_round" do
      subject { Championship.new(current_round: 20) }

      its(:current_round) { should be 20 }
    end

    describe "#total_rounds" do
      subject { Championship.new(total_rounds: 40) }

      its(:total_rounds) { should be 40 }
    end

    describe "#classification" do
      it 'should call all from championship passing the id' do
        ChampionshipClassification.should_receive(:all).with(championship: 12)
        Championship.new(source_id: 12).classification
      end
    end

    describe "#teams" do
      it 'should call all from championship passing the id' do
        Team.should_receive(:all).with(championship: 12)
        Championship.new(source_id: 12).teams
      end
    end

    describe "#matches" do
      it 'should call all from championship passing the id' do
        Match.should_receive(:all).with(championship: 12)
        Championship.new(source_id: 12).matches
      end
    end
  end
end