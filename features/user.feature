@javascript
Feature: User
  Background:
    Given I am on the home page
    And there is a user

  Scenario: Opening the login modal
    Then I should not see the login modal
    When I follow "Login/Register"
    Then I should see the login modal

    When I click outside of the modal
    Then I should not see the login modal

  Scenario: Logging in
    When I login in via the web interface
    Then I should not see the login modal
    And I should be logged in

  Scenario: Logging out
    Then I should not be logged in

    When I login in via the web interface
    Then I should be logged in

    When I click on my username in the navbar
    And I click on the logout link
    Then I should not be logged in

  Scenario: Maintaining session
    When I login in via the web interface
    Then I should be logged in

    When I reload the page
    Then I should still be logged in

  Scenario: Register
    When I follow "Login/Register"
    And I click on the registration link
    And I fill in "register-email" with "new@example.com"
    And I fill in "register-username" with "Joffre"
    And I fill in "register-password" with "secret123"
    And I fill in "register-password-confirmation" with "secret123"
    And I press "Register"
    Then I should see "Username has already been taken"

    When I fill in "register-username" with "Archibald"
    And I press "Register"
    Then I should be logged in
