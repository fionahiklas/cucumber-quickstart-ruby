require 'hiklas/utils/lumber'


module Hiklas

  module Test

    module Clients

      module WebpageClientConstants
        WEBPAGE_CLIENT_OPTIONS = 'webpage_client'
        BASE_URL = 'base_url'
        DEFAULT_CLIENT = 'default_client'
      end

      ##
      #
      # This class describes the functionality for a generic web page client
      #
      # The intention is to provide a generic API to loading/reading/testing
      # web pages which can then be implemented using various different
      # approaches.  For example using Selenium to launch a browser or
      # Nokogiri to simply read the HTML and allow it to be parsed and checked
      #
      # The reason for providing different ways to access web pages is to
      # deal with different test environments: in some cases we need to run
      # against jenkins with a headless setup, in others we need to have the
      # browser render using dynamic content in some cases.
      #
      # While this API must stay generic and be implementable by all of the
      # approaches we use, there may still be differences in the results of a
      # request so it should not be assumed that all tests will pass with all
      # clients.  For example where JavaScript renders some content, a
      # nokogiri client would not see any markup created in that way.  This is
      # why the client to be used is selected as a step in the tests - QAs can
      # control how pages are tested.
      #
      #
      class WebpageClient

        include Hiklas::Lumber::LumberJack
        include Hiklas::Test::Clients::WebpageClientConstants

        @@lumber = lumber(self.name)

        attr_accessor :useSSL


        def initialize(options)
          @options = options
          @useSSL = false
        end

        ##
        #
        # Carry out any setup before running a test
        #
        # The <options> parameter can be used to pass values that control how
        # this client is setup.
        #
        def setup_client_for_test(options=nil)
          raise 'Not implemented'
        end


        ##
        #
        # After a test has been run this can clean a client to remove
        # any cached data/cookies that should not be retained
        #
        def clean_client_after_test
          raise 'Not implemented'
        end


        ##
        #
        # Shutdown and destroy a client when it is no longer needed
        #
        def destroy_client
          raise 'Not implemented'
        end


        def goto_page_relative(relativePageUrl)
          @@lumber.debug("Go to relative URL: '%s'", relativePageUrl)
          absolute_url = make_absolute_url(relativePageUrl)
          @@lumber.debug("Go to absolute URL: '%s'", absolute_url)
          goto_page(absolute_url)
        end


        def goto_page_absolute(absolutePageUrl)
          @@lumber.debug("Go to absolute URL: '%s'", absolutePageUrl)
          goto_page(absolutePageUrl)
        end


        def valid_html_page(expectedValidPage)
          @@lumber.debug("Checking for a valid html page, expected: '%s'", expectedValidPage.to_s)

          error_page = invalid_page()

          # if we expected a valid HTML and got an error then we failed.
          # If we didnt expect a valid HTML and didnt get an error page then we also failed
          # Otherwise we are good to go.
          # (failure if equal otherwise success)
          # This is not a bit complicated to think about, the truth table may help
          # error_page | expected valid HTML |  result | description
          #      false |   false             |   false |  valid HTML and no error page  but we didn't expect HTML, therefore failure
          #      false |   true              |   true  |  valid HTML and no error page and we expected HTML so all good
          #      true  |   false             |   true  |  error page found or no HTML and we expected valid page therefore failure
          #      true  |   true              |   false |  error page found or no HTML but we didn't expect HTML so all_good
          #
          (error_page != expectedValidPage)
        end

        def find_element_by_id(id)
          raise 'Not implemented'
        end

        protected

        ##
        #
        # Access a given page.
        #
        # The absolutePageUrl is expected to include the protocol (http/https) and everything
        # required to locate a given page.
        #
        def goto_page(absolutePageUrl)
          raise 'Not implemented'
        end

        def search_xml_tag(tag)
          raise 'Not implemented'
        end

        def invalid_page()
          raise 'Not implemented'
        end

        def find_error_text_or_null(text)
          raise 'Not implemented'
        end

        def make_absolute_url(relative_url)
          @@lumber.debug("Assumebling absolute URL: protocol '%s', base '%s', relative url '%s'",
                         http_protocol,
                         base_url,
                         relative_url)
          separator_slash = (relative_url[0]=='/') ? '' : '/'
          http_protocol + '://' + base_url + separator_slash + relative_url
        end


        def http_protocol
          (@useSSL) ? 'https' : 'http'
        end

        def base_url
          config[WEBPAGE_CLIENT_OPTIONS][BASE_URL]
        end

        def client_id
          "default"
        end

        def webclient_option
          @@lumber.error("No options provided") if @options == nil
          @@lumber.error("No webpage client options") if @options[WEBPAGE_CLIENT_OPTIONS] == nil
          @@lumber.error("No client options for '%s'", client_id) if @options[WEBPAGE_CLIENT_OPTIONS][client_id] == nil
          @options[WEBPAGE_CLIENT_OPTIONS][client_id]
        end

        def generic_option(key)
          @@lumber.error("No options provided") if @options == nil
          @@lumber.error("No client option for '%s'", key) if @options[key] == nil
          @options[key]
        end

      end # WebpageClient

    end # Client

  end # Test

end # Hiklas