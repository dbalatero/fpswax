require File.dirname(__FILE__) + '/../spec_helper'

describe Fpswax::IpnRequest do
  before(:each) do
    @test_key = 'mykey'
  end

  describe "initialize" do
    it "should require a params hash and secret key" do
      lambda {
        Fpswax::IpnRequest.new({}, @test_key)
      }.should_not raise_error
    end
  end

  describe "valid?" do
    it "should be false if no signature is provided" do
      req = Fpswax::IpnRequest.new({}, @test_key)
      req.should_not be_valid
    end

    it "should be false if the signature doesn't match up" do
      req = Fpswax::IpnRequest.new({'signature' => 'bad', 'param1' => 'ok'}, @test_key)
      req.should_not be_valid
    end

    it "should be true if the signature does match up" do
      good_params = {
        "tokenID" => "N1CHGCG13NNB4JMVJN1Q1JXIKBQDO4DQ595NRSCTILAU47P7GA7JVQMMJNXRUJFM", 
        "callerReference" => "44441234567fdsa44",
        "action" => "amazon_return",
        "signature" => "UWMe0QT28DYwQvHEBOns+RxQ6EQ=",
        "controller" => "checkout",
        "expiry" => "10/2014",
        "status" => "SC"
      }

      req = Fpswax::IpnRequest.new(good_params, @test_key)
      req.should be_valid
    end
  end
end
