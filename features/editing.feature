@javascript
Feature: Editing
  Background:
    Given there are some cards
    And there is a kingdom by Joffre
    And I am logged in
    And I follow "Browse Kingdoms"

  @search
  Scenario: Updating a kingdom
    When I follow "Joffre's Kingdom"
    Then I should see "Description: Very dangerous kingdom."

    When I press "Open in Builder"
    And I fill in "kingdom-description" with "not very dangerous.."
    And I press "Update Kingdom"
    Then I should see "Successfully updated Joffre's Kingdom"

    When I follow "Joffre's Kingdom"
    Then I should see "Description: not very dangerous.."

  @search
  Scenario: Deleting a kingdom
    Then I should see 1 kingdom

    When I follow "Joffre's Kingdom"
    And I press "Delete"
    And I press "Confirm"
    Then I should see "Successfully deleted Joffre's Kingdom"

    When I follow "Browse Kingdoms"
    Then I should see 0 kingdoms

  @search
  Scenario: Not deleting unless confirmed
    Then I should see 1 kingdom

    When I follow "Joffre's Kingdom"
    And I press "Delete"
    And I press "Cancel"
    Then I should not see "Successfully deleted Joffre's Kingdom"

    When I follow "Browse Kingdoms"
    Then I should see 1 kingdom
