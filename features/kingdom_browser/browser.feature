@javascript
Feature: Kingdom browser
  Background:
    Given there is a kingdom by "Joffre"
    And I am on the home page
    And I follow "Browse Kingdoms"

  Scenario: Listing all kingdoms
    Given there is a kingdom by "Batiatus"
    And I am on the home page
    And I follow "Browse Kingdoms"

    Then I should see "Browsing kingdoms"
    And I should see 2 kingdoms
    And I should see "Joffre's Kingdom"
    And I should see "Batiatus's Kingdom"

  Scenario: Browsing a single
    Then I should see "Browsing kingdoms"
    And I should see "Joffre's Kingdom"
    And I should see "by Joffre"
    When I follow "Joffre's Kingdom"
    Then I should see 2 face up cards
    And I should see "Description:"

  Scenario: Browsing a user's kingdoms
    When I follow "Joffre"
    Then I should see "Browsing Joffre's kingdoms"
    And I should see "Joffre's Kingdom"

  Scenario: Browsing my kingdoms
    Given I am logged in
    And I wait
    And I am on the home page

    When I follow "My Kingdoms"
    Then I should see "Browsing my kingdoms"
    And I should see "Joffre's Kingdom"
