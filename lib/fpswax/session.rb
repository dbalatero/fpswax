module Fpswax
  class Session
    class ParameterRequired < ArgumentError; end

    API_VERSION = '2008-09-17'

    include Mixins::HmacSignature

    attr_accessor :logger

    def initialize(access_key, secret_key, sandbox = true)
      @access_key = access_key
      @secret_key = secret_key
      @sandbox = sandbox

      @logger = Logger.new(STDOUT)
      @logger.level = Logger::WARN
    end

    def in_sandbox?
      @sandbox
    end

    def fps_url
      @sandbox ? 'https://fps.sandbox.amazonaws.com' : 'https://fps.amazonaws.com'
    end

    def api_version
      API_VERSION
    end


    def ipn_request(params)
      IpnRequest.new(params, @secret_key)
    end

    def get_multi_use_pipeline(params)
      validate_required?(params,
                         :callerReference,
                         :globalAmountLimit,
                         :returnURL)

      MultiUsePipelineRequest.new(@access_key,
                                  @secret_key,
                                  params,
                                  in_sandbox?)
    end

    # operations
    # See: http://docs.amazonwebservices.com/AmazonFPS/2008-09-17/FPSAdvancedGuide/Pay.html
    def pay(params)
      validate_required?(params,
                         :CallerReference,
                         :SenderTokenId,
                         :"TransactionAmount.CurrencyCode",
                         :"TransactionAmount.Value")

      get_response(:Pay, PayResponse, params)
    end

    private
    def get_response(action, response_klass, params)
      add_params_for_request!(action, params)
      response = self.class.post(fps_url,
                                 :params => params)

      @logger.debug("get_response") {
        "Got XML response:\n#{response.body}"
      }

      response_klass.new(Nokogiri::XML(response.body))
    end

    def self.post(url, options = {})
      url = URI.parse(url) if url.is_a?(String)
      conn = Net::HTTP.new(url.host, url.port)
      if conn.port == 443
        conn.use_ssl = true
      end

      req = Net::HTTP::Post.new(url.request_uri)
      req.form_data = options[:params]

      conn.start do |http|
        http.request(req)
      end
    end

    def add_params_for_request!(action, params)
      # Required params for all requests:
      # http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/CommonRequestParameters.html
      params.merge!(:Action => action,
                    :AWSAccessKeyId => @access_key,
                    :SignatureVersion => 1,
                    :Timestamp => Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ'),
                    :Version => api_version)

      # Generate an HMAC signature.
      signature = generate_signature_for(params, @secret_key)
      params[:Signature] = signature

      @logger.debug('add_params_for_request!') do
        "Params for request (#{action}): #{params.inspect}"
      end

      params
    end

    def validate_required?(hash, *args)
      args.each do |arg|
        raise(ParameterRequired, "This method requires #{arg} to be passed in!") if !hash[arg]
      end
    end

    def make_request(params)

    end
  end
end
