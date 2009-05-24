require File.dirname(__FILE__) + '/../spec_helper'

describe Fpswax::Error do
  describe "initialize" do
    it "should require a code and a message" do
      lambda {
        Fpswax::Error.new('code', 'message')
      }.should_not raise_error(ArgumentError)
    end
  end

  describe "code" do
    it "should be whatever is passed into the constructor" do
      error = Fpswax::Error.new('mycode', 'msg')
      error.code.should == 'mycode'
    end
  end

  describe "message" do
    it "should be whatever is passed into the constructor" do
      error = Fpswax::Error.new('mycode', 'msg')
      error.message.should == 'msg'
    end
  end
end
