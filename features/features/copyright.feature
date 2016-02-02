@wip @headless
Feature: View the copyright page

Scenario Outline: As a user I want to view the copyright page
  Given I am on the Copyright screen
  Then I am shown the copyright year of <year>

  Examples:
  | year |
  | 2015 |

