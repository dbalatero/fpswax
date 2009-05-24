module Fpswax
  class IpnRequest
    include Mixins::HmacSignature

    def initialize(params, secret_key)
      @signature = params.delete('signature')
      strip_keys_from!(params, 'action', 'controller')
      @params = params
      @secret_key = secret_key
    end

    def valid?
      return false if !@signature
      generate_signature_for(@params, @secret_key) == @signature
    end

    private
    def strip_keys_from!(hash, *keys)
      keys.each do |key|
        hash.delete(key)
      end
    end
  end
end
