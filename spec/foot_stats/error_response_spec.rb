# encoding: utf-8
require 'spec_helper'

module FootStats
  describe ErrorResponse do
    let(:error_response) { ErrorResponse.new(%{
      <string xmlns="http://tempuri.org/">
        {"Erro": {"@Mensagem": "Usuário ou senha Inválidos"}}
      </string>
    }, '500 Internal Server Error') }

    describe '#message' do
      subject { error_response.message }

      it { should eq '500 Internal Server Error' }
    end

    describe '#response' do
      subject { error_response.response }

      it { should include(%{{"Erro": {"@Mensagem": "Usuário ou senha Inválidos"}}}) }
    end

    describe '#each' do
      subject { error_response }

      it 'should iterate and do NOT enter in each statement' do
        subject.each { fail }.should eq []
      end
    end

    describe '#goals' do
      subject { error_response.goals }

      it { should eq [] }
    end

    describe '#cards' do
      subject { error_response.cards }

      it { should eq [] }
    end

    describe '#players' do
      subject { error_response.players }

      it { should eq [] }
    end

    describe '#details' do
      subject { error_response.details }

      it { should eq [] }
    end
  end
end