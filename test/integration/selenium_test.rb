require 'rubygems'
require 'selenium-webdriver'


driver.navigate.to "http://google.com"

element = driver.find_element(:name, 'q')
element.send_keys "Selenium Tutorials"
element.submit

driver.quit

