require 'spec_helper'

module FootStats
  describe Request do
    subject { Request.new(stub(resource_name: 'fake', resource_key: 'fake_key')) }

    before do
      Request.any_instance.stub(:post).and_return('{}')
    end

    describe '#resource_name' do
      its(:resource_name) { should eq 'fake' }
    end

    describe '#resource_key' do
      its(:resource_key) { should eq 'fake_key' }
    end

    describe '#request_url' do
      it 'should return the base url with resource name' do
        Setup.stub(:base_url).and_return('http://foo.com')
        subject.request_url.should eq 'http://foo.com/fake'
      end
    end

    describe '#setup_params' do
      before do
        Setup.stub(:username).and_return('username')
        Setup.stub(:password).and_return('password')
      end

      its(:setup_params) do
        should eq({ Usuario: 'username', Senha: 'password' } )
      end
    end

    describe '#parse' do
      it 'should create a response object' do
        subject.parse.should be_instance_of(Response)
      end
    end
  end
end