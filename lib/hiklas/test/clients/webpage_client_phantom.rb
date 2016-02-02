require 'hiklas/utils/lumber'
require 'hiklas/config/config_world'
require 'hiklas/test/clients/webpage_client'

module Hiklas

  module Test

    module Clients

      ##
      #

      #
      #
      class WebpageClientPhantom < WebpageClient

        include Hiklas::Utils::Lumber::LumberJack
        include Hiklas::Config::ConfigWorld

        @@lumber = lumber(self.name)

        PHANTOM_CLIENT_ID = "phantom"


        ##
        #
        # This is private to prevent instances of drivers being created
        #
        def initialize(options)
          super(options)
          @@lumber.debug("Creating phantom driver with options: '%s'", options)
        end

        ##
        #
        # See WebpageClient#setup_client_for_test
        #
        def setup_client_for_test
          @@lumber.debug("About to start client for test")
        end


        ##
        #
        # See WebpageClient#clean_client_after_test
        #
        def clean_client_after_test
          @@lumber.debug("Clean client after a test")
        end


        ##
        #
        #
        def destroy_client
          @@lumber.debug("Destroying client")
        end

        protected

        def client_id
          PHANTOM_CLIENT_ID
        end

      end # WebpageClientPhantom

    end # Client

  end # Test

end # Hiklas