
require 'hiklas/utils/lumber'
require 'hiklas/test/clients/webpage_client_manager'

module Hiklas

    module Test

      module Steps

        ##
        #
        # Steps for interacting with copyright screen
        #
        # This module needs to be included in the World object using the following
        # code
        #
        #   World(Hiklas::Test::Steps::Copyright)
        #
        # Any instance variables (@-prefixed ones) will be on the World object when
        # a test runs. This means any such variables are accessible by any other
        # methods on the World object and from all steps
        #
        # The module will be included in the World object as part of the step definition
        # code so does not need to be added explictly in support.rb
        #
        module Copyright

          include Hiklas::Utils::Lumber::LumberJack
          include Hiklas::Test::Clients::WebpageClientManagerConstants

          @@lumber = lumber(self.name)
          
          ELEMENT_IDS = "element_ids"
          COPYRIGHT_YEAR = "copyright_year"


          def copyright_year(year)
            @current_year = year
            element = @webpage_client.find_element_by_id(config[ELEMENT_IDS][COPYRIGHT_YEAR])
          end

        end

      end # Steps

    end # Test

end # Hiklas

