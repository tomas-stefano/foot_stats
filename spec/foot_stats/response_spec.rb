# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Response do
    let(:some_response) do
      %{
        <string xmlns="http://tempuri.org/">
          { "Campeonato": [ { "@Id": "172" } ] }
        </string>
      }
    end

    let(:successful_response) { Response.new(resource_key: 'Campeonato', body: some_response) }

    let(:other_response) do
      %{
        <string xmlns="http://tempuri.org/">
          {"Erro": {"@Mensagem": "Usuário ou senha Inválidos"}}
        </string>
      }
    end

    let(:error_response) { Response.new(resource_key: 'Campeonato', body: other_response) }

    describe '#error?' do
      context 'when is true' do
        subject { error_response }

        its(:error?) { should be true }
      end

      context 'when is false' do
        subject { successful_response }

        its(:error?) { should be false }
      end
    end

    describe '#error' do
      context 'when is true' do
        subject { error_response }

        its(:error) { should eq(ErrorResponse.new('Usuário ou senha Inválidos')) }
      end

      context 'when is false' do
        subject { successful_response }

        its(:error) { should be nil }
      end
    end

    describe '#[]' do
      subject { successful_response[0] }

      it { should eq({ '@Id' => '172' }) }
    end

    describe '#collect' do
      subject { successful_response.collect { |b| b['@Id'] } }

      it { should eq ['172'] }
    end

    describe '#map' do
      subject { successful_response.map { |b| b['@Id'] } }

      it { should eq ['172'] }
    end
  end
end