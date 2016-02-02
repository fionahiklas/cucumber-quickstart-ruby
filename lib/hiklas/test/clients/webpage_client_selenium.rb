require 'hiklas/util/lumber'
require 'hiklas/config/config_world'
require 'hiklas/test/clients/webpage_client'
require 'selenium-webdriver'

module Hiklas

  module Test

    module Clients

      ##
      #

      #
      #
      class WebpageClientSelenium < WebpageClient

        include Hiklas::Lumber::LumberJack
        include Hiklas::Config::ConfigWorld

        @@lumber = lumber(self.name)

        SELENIUM_CLIENT_ID = "selenium"
        BROWSER = 'browser'
        DEFAULT_BROWSER = :firefox

        ##
        #
        # This is private to prevent instances of drivers being created
        #
        def initialize(options)
          super(options)
          @@lumber.debug("Creating selenium driver with options: '%s'", options)
          @driver = Selenium::WebDriver.for(browser)
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
          @driver.close
          @@lumber.debug("Destroyed")
        end


        def browser
          webclient_option[BROWSER].to_sym || DEFAULT_BROWSER
        end

        def find_element_by_id(id)
          @driver.find_element(:id, id) # TODO: This needs to be a generic element or object to return, or at least a wrapper
        end


        protected

        ##
        #
        # See WebpageClient#goto_page
        #
        def goto_page(pageUrl)
          @@lumber.debug("Goto page '%s'", pageUrl)
          result = @driver.navigate.to(pageUrl)
          currentUrl = @driver.current_url
          @@lumber.debug("Navigation result: '%s', current_url: '%s'", result, currentUrl)
        end

        def search_xml_tag(tag)
          @@lumber.debug("Finding tag in document: '%s'", tag)
          result = nil
          begin
            xpath_expression = "//#{tag}"
            result = @driver.find_element(:xpath, xpath_expression)
          rescue Selenium::WebDriver::Error::NoSuchElementError
            @@lumber.debug("Selenium couldn't find '%s'", xpath_expression)
          end

          result # TODO: This needs to be a generic element or object to return, or at least a wrapper
        end

        def invalid_page()
          find_error_text_or_null("Whitelabel Error Page")
        end

        def find_error_text_or_null(text)
          @@lumber.debug("Finding text in document (or no document): '%s'", text)
          error_page = false

          div = @driver.find_element(:xpath, "//body")
          if div == nil then
            error_page = true
          end

          error_page ||= div.text().include? text

          @@lumber.debug("Page error: '%s', text: '%s'", error_page, text)
          error_page
        end

        def client_id
          SELENIUM_CLIENT_ID
        end

      end # WebpageClient

    end # Client

  end # Test

end # Hiklas