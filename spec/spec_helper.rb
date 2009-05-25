require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fpswax'

begin
  require 'fakeweb'
  FakeWeb.allow_net_connect = false
rescue LoadError
  abort "You need fakeweb installed to run specs. gem install fakeweb."
end

Spec::Runner.configure do |config|
  
end

def fixture_path(path)
  File.join(File.dirname(__FILE__), "fixtures", path)
end

def fixture_raw_xml(path)
  Nokogiri::XML(File.read(fixture_path(path)))
end

def mock_xml
  Nokogiri::XML("<id>2</id>")
end
