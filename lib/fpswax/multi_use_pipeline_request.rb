module Fpswax
  class MultiUsePipelineRequest
    include Mixins::HmacSignature

    CBUI_SANDBOX_URL = 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'.freeze
    CBUI_PRODUCTION_URL = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'.freeze
    CBUI_API_VERSION = '2009-01-09'

    attr_reader :url

    def initialize(access_key, secret_key, params, sandbox = true)
      @access_key = access_key
      @sandbox = true
      @params = params
      add_default_params!
      @signature = generate_signature_for(@params, secret_key)
      create_url!
    end

    private
    def cbui_url
      @sandbox ? CBUI_SANDBOX_URL : CBUI_PRODUCTION_URL
    end

    def cbui_api_version
      CBUI_API_VERSION
    end

    def add_default_params!
      @params[:callerKey] = @access_key
      @params[:pipelineName] = 'MultiUse'
      @params[:version] = cbui_api_version 
    end

    def create_url!
      @url = "" << cbui_url << "?awsSignature=#{@signature}&"
      @url << @params.keys.map { |key| "#{key}=#{@params[key]}" }.join('&')
    end
  end
end
