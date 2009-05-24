require File.dirname(__FILE__) + '/../spec_helper'

describe Fpswax::Session do
  describe "initialize" do
    it "should take an access key, private key" do
      lambda {
        Fpswax::Session.new('a', 'b')
      }.should_not raise_error
    end

    it "should also be allowed to operate in sandbox mode" do
      lambda {
        Fpswax::Session.new('a', 'b', true)
      }.should_not raise_error
    end
  end

  describe "in_sandbox?" do
    it "should by default be in sandbox mode" do
      session = Fpswax::Session.new('a', 'b')
      session.should be_in_sandbox
    end

    it "should not be in sandbox if sandbox is passed in as false" do
      session = Fpswax::Session.new('a', 'b', false)
      session.should_not be_in_sandbox
    end
  end

  describe "api_version" do
    it "should be 2008-09-17" do
      session = Fpswax::Session.new('a', 'b', false)
      session.api_version.should == '2008-09-17'
    end
  end

  describe "cbui_api_version" do
    session = Fpswax::Session.new('a', 'b', false)
    session.cbui_api_version.should == '2009-01-09'
  end

  describe "pay" do
    before(:each) do
      @session = Fpswax::Session.new('a', 'b', true)
      @valid_params = { 
        :CallerReference => 'a',
        :SenderTokenId => 'b',
        :TransactionAmount => 'c'
      }
    end

    it "should return a PayResponse" do
      pending
      response = @session.pay(@valid_params)
      response.should be_an_instance_of(PayResponse)
    end

    describe "should validate parameters" do
      it "and raise an error if no valid params are passed" do
        @valid_params.keys.each do |key|
          bad_params = @valid_params.dup
          bad_params.delete(key)
          lambda {
            @session.pay(bad_params)
          }.should raise_error(Fpswax::Session::ParameterRequired)
        end
      end

      it "and not raise an error if valid params are passed" do
        lambda {
          @session.pay(@valid_params)
        }.should_not raise_error(Fpswax::Session::ParameterRequired)
      end
    end
  end
end
