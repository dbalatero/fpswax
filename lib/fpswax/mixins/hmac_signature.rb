require 'base64'
require 'openssl/digest'

module Fpswax
  module Mixins
    module HmacSignature
      private
      def generate_signature_for(params, secret_key)
        query   = params.sort_by { |k,v| k.to_s.downcase }
        digest  = OpenSSL::Digest::Digest.new('sha1')
        hmac    = OpenSSL::HMAC.digest(digest, secret_key, query.to_s)
        encoded = Base64.encode64(hmac).chomp
      end
    end
  end
end
