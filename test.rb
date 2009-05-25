#!/usr/bin/env ruby

require 'ruby-debug'
require 'lib/fpswax'

$DEBUG = true

FPS_ACCESS_KEY = "1N2G2X8M88XC4KTYRHG2"
FPS_SECRET_KEY = "yQHr7PhLOfBkpnaK1MbPBcDxKKO6snAW500f3Lyl"

session = Fpswax::Session.new(FPS_ACCESS_KEY, FPS_SECRET_KEY)
session.logger.level = Logger::DEBUG
abort "fuck" unless session.in_sandbox?

session.pay(:CallerReference => 'klkjdslfkdsjlkfdsa',
            :SenderTokenId => 'N1CHGCG13NNB4JMVJN1Q1JXIKBQDO4DQ595NRSCTILAU47P7GA7JVQMMJNXRUJFM',
            :"TransactionAmount.CurrencyCode" => 'USD',
            :"TransactionAmount.Value" => 5.50)

=begin
api = Remit::API.new(FPS_ACCESS_KEY, FPS_SECRET_KEY, true)

amount = Remit::RequestTypes::Amount.new(
  :currency_code => 'USD',
  :value => 5.50)
req = Remit::Pay::Request.new(
                 :caller_reference => 'kldsfkjldsa',
                 :sender_token_id => 'nognoolie',
                 :transaction_amount => amount)
puts req.version
debugger
result = api.pay(req)

debugger

puts "done"
=end
