# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fpswax}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Balatero"]
  s.date = %q{2009-05-25}
  s.email = %q{david@bitwax.cd}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/fpswax.rb",
    "lib/fpswax/error.rb",
    "lib/fpswax/ipn_request.rb",
    "lib/fpswax/mixins/hmac_signature.rb",
    "lib/fpswax/pay_response.rb",
    "lib/fpswax/response.rb",
    "lib/fpswax/session.rb",
    "spec/fixtures/pay/cancelled.xml",
    "spec/fixtures/pay/error.xml",
    "spec/fixtures/pay/failure.xml",
    "spec/fixtures/pay/pending.xml",
    "spec/fixtures/pay/reserved.xml",
    "spec/fixtures/pay/success.xml",
    "spec/fixtures/raw/errors.xml",
    "spec/fixtures/raw/request_id.xml",
    "spec/fpswax/error_spec.rb",
    "spec/fpswax/ipn_request_spec.rb",
    "spec/fpswax/mixins/hmac_signature_spec.rb",
    "spec/fpswax/pay_response_spec.rb",
    "spec/fpswax/response_spec.rb",
    "spec/fpswax/session_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/dbalatero/fpswax}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{A library for interfacing with Amazon FPS, without any "cleverness".}
  s.test_files = [
    "spec/fpswax/error_spec.rb",
    "spec/fpswax/ipn_request_spec.rb",
    "spec/fpswax/mixins/hmac_signature_spec.rb",
    "spec/fpswax/pay_response_spec.rb",
    "spec/fpswax/response_spec.rb",
    "spec/fpswax/session_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.2.3"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.2.3"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.2.3"])
  end
end
