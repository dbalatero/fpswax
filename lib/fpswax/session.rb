module Fpswax
  class Session
    class ParameterRequired < ArgumentError; end

    API_VERSION = '2008-09-17'
    CBUI_API_VERSION = '2009-01-09'

    include Mixins::HmacSignature

    def initialize(access_key, secret_key, sandbox = true)
      @access_key = access_key
      @secret_key = secret_key
      @sandbox = sandbox
    end

    def in_sandbox?
      @sandbox
    end

    def api_version
      API_VERSION
    end

    def cbui_api_version
      CBUI_API_VERSION
    end

    # operations
    # See: http://docs.amazonwebservices.com/AmazonFPS/2008-09-17/FPSAdvancedGuide/Pay.html
    def pay(params)
      validate_required?(params,
                         :CallerReference,
                         :SenderTokenId,
                         :TransactionAmount)

      #get_response('Pay', PayResponse, params)
    end

    private
    def validate_required?(hash, *args)
      args.each do |arg|
        raise(ParameterRequired, "This method requires #{arg} to be passed in!") if !hash[arg]
      end
    end

    def make_request(params)

    end
  end
end
