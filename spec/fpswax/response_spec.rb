require File.dirname(__FILE__) + '/../spec_helper'

describe Fpswax::Response do
  describe "request_id" do
    it "should successfully be parsed from a response" do
      xml = fixture_raw_xml('raw/request_id.xml')
      response = Fpswax::Response.new(xml)
      response.request_id.should == 'b415f09d-5924-4315-b31a-21c977c85c39:0'
      response.should be_valid
    end
  end

  describe "errors" do
    it "should return any errors that were present in the XML response" do
      xml = fixture_raw_xml('raw/errors.xml')
      response = Fpswax::Response.new(xml)

      response.errors.should have_at_least(1).thing
    end
  end

  describe "valid" do
    it "should be true if there are no errors" do
      xml = fixture_raw_xml('raw/request_id.xml')
      response = Fpswax::Response.new(xml)
      response.should be_valid
    end

    it "should be false if there are errors" do
      xml = fixture_raw_xml("raw/errors.xml")
      response = Fpswax::Response.new(xml)
      response.should_not be_valid
    end
  end
end
