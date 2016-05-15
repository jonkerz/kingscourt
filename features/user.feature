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
    And I follow "Logout"
    Then I should not be logged in

  Scenario: Maintaining session
    When I login in via the web interface
    Then I should be logged in

    When I reload the page
    Then I should still be logged in

  Scenario: Register
    When I follow "Login/Register"
    #And I click on the registration link
    And I follow "Registration"
    And I fill in "register-email" with "new@example.com"
    And I fill in "register-username" with "Joffre"
    And I fill in "register-password" with "secret123"
    And I fill in "register-password-confirmation" with "secret123"
    And I press "Register"
    Then I should see "Username has already been taken"

    When I fill in "register-username" with "Archibald"
    And I press "Register"
    Then I should be logged in

  Scenario: Change password
    When I login in via the web interface
    And I click on my username in the navbar
    And I follow "Change password"
    And I fill in "change-password" with "new_password"
    And I fill in "change-password-confirmation" with "new_password"
    And I press "Change password"
    Then I should see "Your password has been successfully updated."

    When I click outside of the modal
    And I click on my username in the navbar
    And I follow "Logout"
    Then I should not be logged in

    When I follow "Login/Register"
    And I fill in "login-email" with "joffre@example.com"
    And I fill in "login-password" with "secret123"
    And I press "Login"
    Then I should see "Invalid credentials"

    When I fill in "login-password" with "new_password"
    And I press "Login"
    Then I should be logged in
