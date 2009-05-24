require 'base64'
require 'openssl/digest'

module Fpswax
  class IpnRequest
    def initialize(params, secret_key)
      @signature = params.delete('signature')
      @params = params
      @secret_key = secret_key
    end

    def valid?
      return false if !@signature
      generate_signature_for(@params) == @signature
    end

    private
    def generate_signature_for(params)
      query   = params.sort_by { |k,v| k.downcase }
      digest  = OpenSSL::Digest::Digest.new('sha1')
      hmac    = OpenSSL::HMAC.digest(digest, @secret_key, query.to_s)
      encoded = Base64.encode64(hmac).chomp
    end

    def strip_keys_from(hash, *keys)
      keys.each do |key|
        hash.delete(key)
      end
    end
  end
end
