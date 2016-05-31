@javascript
Feature: Responsive layout
  Background:
    Given I am logged in

  @responsive
  Scenario: Navigation
    When I resize the browser window to large
      Then I should not see the menu hamburger
      And I should see "Browse Kingdoms"
      And I should see "My Kingdoms"

    When I resize the browser window to medium
      Then I should not see the menu hamburger
      And I should see "Browse Kingdoms"
      And I should see "My Kingdoms"

    When I resize the browser window to small
      Then I should not see the menu hamburger
      And I should see "Browse Kingdoms"
      And I should not see "My Kingdoms"

    When I resize the browser window to extra_small
      Then I should see the menu hamburger
      And I should not see "Browse Kingdoms"
      And I should not see "My Kingdoms"