$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'openssl'
require 'nokogiri'

require 'fpswax/mixins/hmac_signature'

require 'fpswax/error'
require 'fpswax/ipn_request'

module Fpswax
end
