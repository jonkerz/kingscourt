Feature: User
  Background:
    Given I am on the home page

  Scenario: Opening the login modal
    When I am on the home page
    Then I should not see the login modal
    When I follow "Login/Register"
    Then I should see the login modal
