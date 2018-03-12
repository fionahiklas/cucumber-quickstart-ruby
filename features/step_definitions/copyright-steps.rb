require 'hiklas/test/steps/copyright'

# Add the module methods into the Cucumber World
World(Hiklas::Test::Steps::Copyright)


When (/^I enter a ([\w]+) and Search$/) do |searchValue|
  search_for(searchValue)
end

