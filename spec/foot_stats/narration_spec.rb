# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Narration do
    describe ".all" do
      context "null narration" do
        use_vcr_cassette 'match_null_narration'
        let(:empty_narrations) { Narration.all(match: 19).first }
        subject { empty_narrations }

        its(:championship_id)  { should eq 172 }
        its(:name)           { should eq 'Camp. Mineiro 2012' }
        its(:season)         { should eq '2012' }
        its(:match_id)       { should eq 34829 }
        its(:score)          { should eq ' - ' }
        its(:has_penalty)    { should eq 'Nao' }

        its(:details)          { should eq [] }
      end

      context "with narrations" do
        use_vcr_cassette 'match_narration'
        let(:narrations) { Narration.all(match: 19).first }
        subject { narrations }

        its(:championship_id)    { should eq 172 }
        its(:name)         { should eq 'Camp. Mineiro 2012' }
        its(:season)       { should eq '2012' }
        its(:match_id)     { should eq 34829 }
        its(:score)        { should eq ' - ' }
        its(:has_penalty)  { should eq 'Nao' }

        context "narrations" do
          subject { narrations.details.first }

          its(:source_id)        { should eq 109 }
          its(:team_source_id)   { should eq 18 }
          its(:team_name)        { should eq 'Santos' }
          its(:player_source_id) { should eq 11 }
          its(:player_name)      { should eq 'Neymar' }
          its(:period)           { should eq '1' }
          its(:moment)           { should eq '23' }
          its(:description)      { should eq 'Impedimento' }
          its(:action)           { should eq 'acao' }
        end
      end

      context "error response" do
        use_vcr_cassette 'match_narration_error_response'
        subject { Narration.all(match: 19) }

        its(:message) { should eq 'Usuário ou senha Inválidos' }
      end
    end

    describe ".resource_name" do
      subject { Narration }

      its(:resource_name) { should eq 'Narracao' }
    end

    describe ".resource_key" do
      subject { Narration }

      its(:resource_key) { should eq 'Campeonato' }
    end
  end
end