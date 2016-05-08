@javascript
Feature: Kingdom browser
  Background:
    Given there is a kingdom
    And I am on the home page
    And I follow "Browse Kingdoms"

  Scenario: Listing all kingdoms
    Then I should see "Browsing kingdoms"
    And I should see "Dangerous Kingdom"

  Scenario: Browsing a single
    Then I should see "Browsing kingdoms"
    And I should see "Dangerous Kingdom"
    And I should see "by Joffre"
    When I follow "Dangerous Kingdom"
    Then I should see 2 face up cards
    And I should see "Description:"

  Scenario: Browsing a user's kingdoms
    When I follow "Joffre"
    Then I should see "Browsing Joffre's kingdoms"
    And I should see "Dangerous Kingdom"
