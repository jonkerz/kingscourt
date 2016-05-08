@javascript
Feature: User
  Background:
    Given I am on the home page

  Scenario: Opening the login modal
    Then I should not see the login modal
    When I follow "Login/Register"
    Then I should see the login modal

    When I click outside of the modal
    Then I should not see the login modal

  Scenario: Logging in
    Given there is a user
    When I follow "Login/Register"
    And I fill in "login-email" with "king@example.com"
    And I fill in "login-password" with "secret123"
    And I press "Login"
    Then I should not see the login modal
    And I should be logged in
