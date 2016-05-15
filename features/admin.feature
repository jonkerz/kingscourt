@javascript
Feature: Admin dashboard
  Scenario: Non-admins cannot log in
    Given there is a user
    When I go to the admin panel
    Then I should see "You need to sign in or sign up before continuing."

    When I fill in "user_email" with "joffre@example.com"
    And I fill in "user_password" with "secret123"
    And I sign in
    Then I should see "Signed in successfully"

    When I follow "Admin"
    Then I should see "Not an admin"

  Scenario: Admins can log in
    Given there is an admin user named KingsAdmin
    When I go to the admin panel
    And I fill in "user_email" with "admin@example.com"
    And I fill in "user_password" with "secret123"
    And I sign in
    Then I should see "Dashboard"
