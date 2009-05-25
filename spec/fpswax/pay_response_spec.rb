require File.dirname(__FILE__) + '/../spec_helper'

describe Fpswax::PayResponse do
  it "should be a Response" do
    pay = Fpswax::PayResponse.new(mock_xml)
    pay.should be_a_kind_of(Fpswax::Response)
  end

  it "should handle errors correctly" do
    pay = Fpswax::PayResponse.new(fixture_raw_xml('pay/error.xml'))
    pay.should_not be_valid
    pay.errors.should have(1).thing
  end

  describe "any pay response" do
    before(:each) do
      @pay = Fpswax::PayResponse.new(fixture_raw_xml('pay/pending.xml'))
    end

    it "should have its transaction status" do
      @pay.transaction_status.should == 'Pending'
    end

    it "should have its transaction ID" do
      @pay.transaction_id.should == '145ST343M4FVUENSE545EV1BL7H6OU421QP'
    end
  end

  ['cancelled', 'failure', 'pending', 'reserved', 'success'].each do |status|
    describe "a pending pay response" do
      before(:each) do
        @pay = Fpswax::PayResponse.new(fixture_raw_xml("pay/#{status}.xml"))
      end

      it "should be valid" do
        @pay.should be_valid
      end

      it "should be #{status}" do
        @pay.send("#{status}?".to_sym).should be_true
      end
    end
  end
end
