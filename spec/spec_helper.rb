require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fpswax'

Spec::Runner.configure do |config|
  
end

def fixture_path(path)
  File.join(File.dirname(__FILE__), "fixtures", path)
end

def fixture_raw_xml(path)
  Nokogiri::XML(File.read(fixture_path(path)))
end
