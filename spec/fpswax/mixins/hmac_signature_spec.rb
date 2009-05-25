require File.dirname(__FILE__) + '/../../spec_helper'

describe Fpswax::Mixins::HmacSignature do
  include Fpswax::Mixins::HmacSignature

  describe "generate_signature_for" do
    it "should accept symboled keys" do
      lambda {
        generate_signature_for({:key1 => 'ok'}, 'my key')
      }.should_not raise_error
    end
  end
end
