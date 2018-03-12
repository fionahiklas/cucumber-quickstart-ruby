require 'hiklas/test/steps/general'

# Add the module methods into the Cucumber World
World(Hiklas::Test::Steps::General)


Given (/^I connect with a (browser|headless client|phantom client)$/) do |client|
  @webpage_client = choose_webpage_client(client)
end

Given (/^I (do|do not) use SSL$/) do |useSSL|
  use_ssl_choice = (useSSL == 'do')
  @webpage_client.useSSL = use_ssl_choice
end


Given (/^I am on the ([\w ]+) screen$/) do |screenName|
  i_am_on_screen(screenName)
end


When (/^I attempt to go to page ([\/\w\.-_]+)$/) do |page|
  @webpage_client.goto_page_relative(page)
end


Then (/^I get the HTTP code ([0-9]+)$/) do |httpCodeString|
  pending
end


Then (/^I (|do|do not|don't) get a HTML page$/) do |doString|
  expect_page = do_or_donot(doString)
  check_html_page(expect_page)
end

Then (/^I can see a ([\w]+) tag containing the text '([.]+)'$/) do |tagName, tagString|
  pending
end

Given (/^I have to test$/) do
  pending
end

Given (/^I wrote this$/) do 
  pending
end

When (/^I can't be bothered to test$/) do 
  pending
end

Then (/^nothing happens$/) do 
  pending
end

Then (/^I'm lazy$/) do
  pending
end

Then (/^I go home early$/) do 
  pending
end
