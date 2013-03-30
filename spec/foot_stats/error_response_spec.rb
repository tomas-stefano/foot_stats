require 'spec_helper'

module FootStats
  describe ErrorResponse do
    let(:error_response) { ErrorResponse.new('500 Internal Server Error') }

    describe '#message' do
      subject { error_response.message }

      it { should eq '500 Internal Server Error' }
    end

    describe '#response' do
      subject { error_response.response }

      it { should eq '500 Internal Server Error' }
    end

    describe '#each' do
      subject { error_response }

      it 'should iterate and do NOT enter in each statement' do
        subject.each { fail }.should eq []
      end
    end
  end
end