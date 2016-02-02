require 'yaml'

require 'hiklas/util/lumber'

module Hiklas

  module Config

    ##
    #
    # Central location for all of the configuration for the automated tests.
    #
    # An instance of this class is created as a singleton by the GlobalConfigHelper
    # module below.  That module is intended for inclusion in the Cucumber World object
    # so that the functionality is available as instance methods.
    #
    # The configuration relies on merging of YAML files.  In any of these keys can be
    # redefined so that environment specific values override defaults.
    #
    class Config

      include Hiklas::Lumber::LumberJack

      @@log = lumber(self.name)

      # This is used for reading environment variables
      ENVIRONMENT_ENV = 'ENVIRONMENT'
      CONFIG_ENV = 'TEST_CONFIG_FILES'

      # This is used for reading the initial setup from YAML files
      ENVIRONMENT_KEY = ENVIRONMENT_ENV.downcase
      CONFIG_KEY = CONFIG_ENV.downcase

      DEFAULT_CONFIG_DIRECTORY = 'config'

      ##
      #
      # Create an instance of the GlobalConfig object
      #
      # Need to know the base directory for the config files.  This either defaults to
      # 'config' or is read from an environment variable
      #
      def initialize
        # Start with an empty hash
        @config = {}

        # Make sure we know which environment and location
        bootstrapEnvironment
      end


      def environment
        @config[ENVIRONMENT_KEY]
      end


      def config_directory
        @config[CONFIG_KEY]
      end


      def load
        # The common files that will always be needed
        loadMainConfigFile

        # Environment specific file
        loadEnvironmentFile
      end


      def [](key)
        @config[key]
      end

      def check(key)
        value = self[key]
        raise "Option '#{key}' missing from config" if value.nil?
        value
      end

      def fetch(key, &block)
        @config.fetch(key, &block)
      end

      ##
      #
      # Merges two hashes together.
      #
      # For configuration files we only expect hashes of a maximum depth of 1.
      # For example
      #
      #   some_key:
      #     sub-key1: blah
      #     sub-key2: blibble
      #
      # This method merges these properly so that specifying just the keys to change
      # will work, e.g. merging the above with
      #
      #  some_key:
      #     sub-key1: more blah
      #
      # will result in the following
      #
      #   some_key:
      #     sub-key1: more blah
      #     sub-key2: blibble
      #
      def mergeConfig!(originalHash, newHash)
        originalHash.merge!(newHash) do |key, originalValue, newValue|
          if originalValue.is_a?(Hash)
            originalValue.merge!(newValue)
          else
            newValue
          end
        end

        originalHash
      end

      def commonFile
        "common"
      end

      def environmentFile
        "environments/#{environment}"
      end

      def fullConfigPath(filename)
        "#{config_directory}" + File::SEPARATOR + "#{filename}.yml"
      end


      # ############# #
      # Class methods #
      # ############# #

      ##
      #
      # Return a singleton instance of the config
      #
      # Unless explicitly created and loaded before hand the config will be
      # loaded on first use.
      #
      def self.globalConfig
        @@globalConfigSingleton ||= createGlobalConfig
      end


      ##
      #
      # Initialize the configuration object and load files.
      #
      # This method is exposed however there should be no need to call it
      # explicitly unless there is a need to force loading of config at a given point.
      # You might want to do this to fail fast for example if the config changes alot
      # and loading could fail
      #
      def self.createGlobalConfig
        @@globalConfigSingleton = Config.new
        @@globalConfigSingleton.load
        @@globalConfigSingleton
      end


      protected

      def bootstrapEnvironment
        @@log.debug("Bootstrapping config")
        @config[CONFIG_KEY] = DEFAULT_CONFIG_DIRECTORY

        # Override this with environment variables
        loadEnvironmentConfig

        @@log.debug("Environment: #{self[ENVIRONMENT_KEY]}")
        @@log.debug("ConfigDirectory: #{self[CONFIG_KEY]}")
      end


      def loadEnvironmentConfig
        @@log.debug("Reading settings from environment")
        @config[ENVIRONMENT_KEY] = ENV[ENVIRONMENT_ENV] if ENV[ENVIRONMENT_ENV]
        @config[CONFIG_KEY] = ENV[CONFIG_ENV] if ENV[CONFIG_ENV]
      end


      private

      def loadMainConfigFile
        mergeConfig!(@config, loadConfigFileFromConfigDirectory(commonFile))
      end


      def loadEnvironmentFile
        mergeConfig!(@config, loadConfigFileFromConfigDirectory(environmentFile))
      end


      def loadConfigFileFromConfigDirectory(filename)
        full_filename = fullConfigPath(filename)
        loadConfigFile(full_filename)
      end


      def loadConfigFile(full_filename)
        @@log.debug("Loading file '%s'", full_filename)
        result = {}

        if File.exists?(full_filename)
          result = YAML::load(fileRead(full_filename))
        else
          @@log.debug("Missing: #{full_filename}")
        end

        result
      end

      def fileRead(full_filename)
        File.read(full_filename)
      end

    end # class Config

  end # Config

end # Hiklas
