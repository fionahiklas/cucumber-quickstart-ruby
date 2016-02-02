@general
Feature: General tests for the Hiklas Homepage

  Scenario Outline: I can see the home page
    Given I connect with a browser
    When I attempt to go to page <page>
    Then I <do_donot> get a HTML page
    Examples:
      | page        | do_donot |
      | /           |   do not |
      | /bibble     |   do not |
      | /tomriddle  |   do not |
      | /           |       do |

