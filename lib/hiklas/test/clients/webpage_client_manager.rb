
require 'hiklas/utils/lumber'
require 'hiklas/config/config_world'
require 'hiklas/test/clients/webpage_client'
require 'hiklas/test/clients/webpage_client_selenium'
require 'hiklas/test/clients/webpage_client_phantom'
require 'hiklas/test/clients/webpage_client_nokogiri'


module Hiklas

    module Test

      module Clients


        module WebpageClientManagerConstants
          BROWSER = :browser
          PHANTOM = :phantom
          HEADLESS = :headless
        end

        ##
        #
        # Constructs WebpageClients and tracks instances
        #
        class WebpageClientManager

          include Hiklas::Utils::Lumber::LumberJack

          @@lumber = lumber(self.name)

          include WebpageClientManagerConstants
          include Hiklas::Config::ConfigWorld


          def initialize
            @client_hash = {}
          end

          def get_client(type_of_client)
            @@lumber.debug("Getting client for type: '%s'", type_of_client)
            @client_hash[type_of_client] ||= create_client(type_of_client)
          end


          def create_client(type_of_client)
            @@lumber.debug("Creating client for type '%s'", type_of_client)
            client_options = get_client_options(type_of_client)
            case
              when BROWSER
                WebpageClientSelenium.new(client_options)
              when PHANTOM
                WebpageClientPhantom.new(client_options)
              when HEADLESS
                WebpageClientNokogiri.new(client_options)
              else
                raise "Can't identify client: #{type_of_client}"
            end
          end


          def get_client_options(type_of_client)
            # For now we are just returning all of the options
            config
          end

          def destroy_clients
            @client_hash.each_key do |client_key|
              @client_hash[client_key].destroy_client
            end
          end

          ##
          #
          # Get the manager singleton
          #
          # We have a single client manager that keeps track of all instances of
          # web page clients.  If there was an IoC/DI framework for Ruby we'd probably
          # use that to create a singleton
          #
          def self.get_manager
            @@manager ||= create_manager
          end


          ##
          #
          # Destroy all of the clients
          #
          # Some clients may need to clean-up before Cucumber exits
          # There is an at_exit hook in the support.rb file that will
          # call this method to carry out some cleanup
          #
          def self.destroy_manager
            @@manager.destroy_clients
          end

          private

          def self.create_manager
            WebpageClientManager.new
          end

        end # WebpageClientManager


        ##
        #
        # Methods to add to the World object for webpage client
        #
        # Allow access to the webpage client
        module WebpageClientManagerWorld

          def webpage_manager
            WebpageClientManager::get_manager
          end

        end

      end # Clients

    end # Test

end # Hiklas