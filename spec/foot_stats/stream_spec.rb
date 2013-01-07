# encoding: utf-8
require 'spec_helper'

module FootStats
  describe Stream do

    context 'clean stream' do
      before :all do
        FootStats::Setup.setup
        @stream = FootStats::Stream.new 'clean-key'
      end

      it 'should have no payload' do
        @stream.payload.should be_nil
      end

      it 'should be marked as updated without care about payload' do
        @stream.updated?('any-key').should be_true
      end

      it 'should be able to store new payload' do
        @stream.store 'new_payload'
        @stream.payload.should == 'new_payload'
      end

      it 'should be marked as updated after storing new payload' do
        @stream.updated?('new_payload').should be_false
      end
    end

    context 'dirty stream' do
      before :all do
        FootStats::Setup.setup
        @stream = FootStats::Stream.new 'dirty-key'
        @stream.store 'dirty-payload'
      end

      it 'should have dirty payload' do
        @stream.payload.should == 'dirty-payload'
      end

      it 'should be marked as updated when payload if different than dirty-payload' do
        @stream.updated?('not-dirty').should be_true
      end

      it 'should be marked as not updated when payload is dirty-payload' do
        @stream.updated?('dirty-payload').should be_false
      end

      it 'should be able to store new payload' do
        @stream.store 'new_payload'
        @stream.payload.should == 'new_payload'
      end

      it 'should be marked as updated after storing new payload' do
        @stream.updated?('new_payload').should be_false
      end
    end

  end
end