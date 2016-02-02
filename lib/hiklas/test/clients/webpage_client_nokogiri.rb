require 'hiklas/utils/lumber'
require 'hiklas/config/config_world'
require 'hiklas/test/clients/webpage_client'

module Hiklas

    module Test

      module Clients

        ##
        #
        # A web page driver that uses Nokogiri to parse HTML
        #
        # This driver can be used in a completely headless environment and requires no
        # graphical resources at all.
        #
        class WebpageClientNokogiri < WebpageClient

          include Hiklas::Utils::Lumber::LumberJack
          include Hiklas::Config::ConfigWorld

          @@lumber = lumber(self.name)

          NOKOGIRI_CLIENT_ID = "nokogiri"

          ##
          #
          # This is private to prevent instances of drivers being created
          #
          def initialize(options)
            super(options)
            @@lumber.debug("Creating nokogiri driver with options: '%s'", options)
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
              NOKOGIRI_CLIENT_ID
            end

        end # WebpageClientNokogiri

      end # Client

    end # Test

end # Hiklas