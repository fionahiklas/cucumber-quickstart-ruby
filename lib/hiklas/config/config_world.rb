require 'hiklas/config/config'

module Hiklas

    module Config

      ##
      #
      # Module for inclusion in the Cucumber World object
      #
      # Load this module into the Cucumber World Object using the following
      #
      #   World(Ott::Test::Config:GlobalConfigHelper)
      #
      # Configuration data can then be accessed using the following in step definitions
      #
      #  config['<config key>']
      #
      # While it would be tempting to make this a class method this would mean the
      # syntax would be a little more verbose (self.config) and also I'm not sure
      # if World(...) would work too well with class methods either
      #
      module ConfigWorld

        ##
        # Instance method intended for use in the Cucumber World object
        #
        def config
          Hiklas::Config::Config::globalConfig
        end

      end # GlobalConfigHelper

    end # Config

end # Hiklas

