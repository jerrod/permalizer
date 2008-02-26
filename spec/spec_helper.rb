$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'spec'

Spec::Runner.configure do |config|
  # config.include(Merb::Test::Helper)
  # config.include(Merb::Test::RspecMatchers)
end