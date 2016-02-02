#
# This is the Lord of the Rings support file ;-)
#
# Everything that is required to support the cucumber tests should be
# included here as this file will be read first before any of the step definitions.
#
# Do NOT add more files to this support directory since there is absolutely no
# guarentee of the order in which they will be loaded on all operating systems.
# FYI it seems like Mac OS X and Windows will load in alphanumeric order however
# Linux and UNIX systems will definitely NOT do this.
#
# Require all necessary libraries below and setup any modules in the Cucumber
# world object so that helper methods are available to step definitions
#

require 'rubygems'
require 'bundler/setup'

# TODO: This is a hack, don't like it!
# TODO: If all the code in lib was in a gem, it would actually load fine!
$LOAD_PATH.unshift File.expand_path("../../../lib", __FILE__)

puts "Cucumber LOADPATH = #{$LOAD_PATH}"

require 'hiklas/lumber'

# Change this to alter the logging levels
Hiklas::Lumber::LumberJack::lumber_level(Hiklas::Lumber::Constants::DEBUG)

require 'hiklas/config/config_world'

# Load the global config method into the World object
# At the point that a test reads a config parameter the yaml files will be
# lazy-loaded.
# TODO: Not entirely sure I like lazy-loading so maybe think about this
World(Hiklas::Config::ConfigWorld)

# This gets the eq method that is used for some of the checks in tests
require 'rspec/expectations'

# This adds the eq methods to the world object
World(RSpec::Matchers)


# =========
# = HOOKS =
# =========

##
#
# This should have the World object as self
#
Before do
  # Do things before every test
end


require 'hiklas/test/clients/webpage_client_manager'

# Provides access to the webpage client manager to steps*
#
# * Cucumber steps that is, not the pop group STEPS, I'm not sure
# if there is a STEPS module in Ruby which is a Tragedy really ;-)
World(Hiklas::Test::Clients::WebpageClientManagerWorld)

at_exit do

  #Hiklas::Test::Clients::WebpageClientManager.destroy_manager
end