require File.dirname(__FILE__) + '/../spec_helper'

describe Fpswax::MultiUsePipelineRequest do
  describe "url" do
    before(:each) do
      @request = Fpswax::MultiUsePipelineRequest.new(
        'my access key',
        'my secret key',
        :returnURL => 'http://return_url'
      )
    end


    it "should add the access key" do
      @request.url.should =~ /callerKey=my access key/
    end

    it "should calculate an HMAC signature" do
      @request.url.should =~ /awsSignature=\w+/
    end

    it "should set a version to 2009-01-09" do
      @request.url.should =~ /version=2009-01-09/
    end

    it "should set pipelineName to MultiUse" do
      @request.url.should =~ /pipelineName=MultiUse/
    end

    it "should contain any parameters passed in" do
      @request.url.should =~ /&returnURL=http:\/\/return_url/
    end
  end
end
