Feature: Admin dashboard
  Scenario: Admins only
    Given there is a user
    When I go to the admin panel
    Then I should see "Dashboard"
