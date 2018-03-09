require 'hiklas/utils/lumber'
require 'hiklas/test/clients/webpage_client_manager'

module Hiklas

  module Test

    module Steps

      ##
      #
      # General steps for interacting with a page
      #
      # This module needs to be included in the World object using the following
      # code
      #
      #   World(Hiklas::Test::Steps::General)
      #
      # Any instance variables (@-prefixed ones) will be on the World object when
      # a test runs. This means any such variables are accessible by any other
      # methods on the World object and from all steps
      #
      # The module will be included in the World object as part of the step definition
      # code so does not need to be added explictly in support.rb
      #
      module General

        include Hiklas::Utils::Lumber::LumberJack
        include Hiklas::Test::Clients::WebpageClientConstants
        include Hiklas::Test::Clients::WebpageClientManagerConstants

        @@lumber = lumber(self.name)

        BROWSER_CLIENT_STRING = "browser"
        PHANTOM_CLIENT_STRING = "phantom client"
        HEADLESS_CLIENT_STRING = "headless client"

        SCREEN_MAPPING = 'screen_names'

        def default_webpage_client
          client_sym_from_config = config[WEBPAGE_CLIENT_OPTIONS][DEFAULT_CLIENT]
        end

        def choose_webpage_client(type_of_client)
          @@lumber.debug("choose_webpage_client, type_of_client: '%s'", type_of_client)

          client_result = nil

          case type_of_client.downcase

            when BROWSER_CLIENT_STRING
              client_result = webpage_manager.get_client(BROWSER)

            when PHANTOM_CLIENT_STRING
              client_result = webpage_manager.get_client(PHANTOM)

            when HEADLESS_CLIENT_STRING
              client_result = webpage_manager.get_client(HEADLESS)

            else
              fail("No valid client selected '#{type_of_client}'")
          end

          client_result
        end


        def check_html_page(expect_page)
          @@lumber.debug("Expect page: %s", expect_page)
          expect(@webpage_client.valid_html_page(expect_page)).to be(true)
        end

        def do_or_donot(doString)
          @@lumber.debug("do_or_donot from '%s'", doString)
          result = false
          case doString
            when '', 'do', 'DO'
              result = true

            when 'do not', 'don\'t'
              result = false

            else
              @@lumber.error("Didn't match!")
          end

          @@lumber.debug("do_or_donot=%s", result.to_s)
          result
        end

        def i_am_on_screen(screenName)
          # TODO: Really it would be better to be explicit about which client we are using
          # TODO: maybe this best with a step that states which client or a config value.
          # TODO: For now we are just going to use a default client from the config UNLESS
          # TODO: a step has already setup the client - this is on a per test basis
          @webpage_client ||= choose_webpage_client(default_webpage_client)

          @webpage_client.goto_page_relative(get_url_from_screen_name(screenName))
        end

        def get_url_from_screen_name(name)
          # The config object is available in the World object
          config[SCREEN_MAPPING][name]
        end

      end # General

    end # Steps

  end # Test

end # Hiklas

