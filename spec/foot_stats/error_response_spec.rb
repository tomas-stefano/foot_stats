require 'spec_helper'

module FootStats
  describe ErrorResponse do
    describe '#each' do
      subject { ErrorResponse.new('500 Internal Server Error') }

      it 'should iterate and do NOT enter in each statement' do
        subject.each { fail }.should eq []
      end
    end
  end
end