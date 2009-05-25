require File.dirname(__FILE__) + '/../spec_helper'

describe Fpswax::Session do
  before(:each) do
    FakeWeb.clean_registry
  end

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

  describe "ipn_request" do
    it "should return an IpnRequest object with the params and secret key passed through" do
      params = { 'test' => 'it' }
      session = Fpswax::Session.new('a', 'b', false)

      request = session.ipn_request(params)
      request.should be_a_kind_of(Fpswax::IpnRequest)
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
        :"TransactionAmount.CurrencyCode" => 'USD',
        :"TransactionAmount.Value" => 'c'
      }
    end

    it "should return a PayResponse" do
      FakeWeb.register_uri(:post,
                           'https://fps.sandbox.amazonaws.com:443/',
                           :file => fixture_path('pay/success.xml'))
      response = @session.pay(@valid_params)
      response.should be_an_instance_of(Fpswax::PayResponse)
      response.should be_valid
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

    describe "fps_url" do
      it "should point at the production API if we are in production" do
        session = Fpswax::Session.new('a', 'b', false)
        session.should_not be_in_sandbox
        session.fps_url.should == 'https://fps.amazonaws.com'
      end

      it "should point at the sandbox API if we aren't in production" do
        session = Fpswax::Session.new('a', 'b', true)
        session.should be_in_sandbox
        session.fps_url.should == 'https://fps.sandbox.amazonaws.com'
      end
    end

    describe "logger" do
      before(:each) do
        @session = Fpswax::Session.new('a', 'b')
      end

      it "should return a logger object" do
        @session.logger.should be_a_kind_of(Logger)
      end

      it "should be able to be set to something else" do
        lambda {
          @session.logger = Logger.new(STDOUT)
        }.should_not raise_error
      end
    end
  end
end
