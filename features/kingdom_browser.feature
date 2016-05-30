@javascript
Feature: Kingdom browser
  Background:
    Given there are some cards
    And there is a kingdom by Batiatus
    And I am on the home page
    And I follow "Browse Kingdoms"

  @search
  Scenario: Listing all kingdoms
    Given there is a kingdom by Joffre
    And I am on the home page
    And I follow "Browse Kingdoms"

    Then I should see "Browsing kingdoms"
    And I should see 2 kingdoms
    And I should see "Joffre's Kingdom"
    And I should see "Batiatus's Kingdom"

  @search
  Scenario: Show base game kingdoms only
    Given there is a kingdom by Joffre
    And I am on the home page
    And I follow "Browse Kingdoms"

    Then I should see "Browsing kingdoms"
    And I should see 2 kingdoms
    When I toggle the expansions "Intrigue" and reload
    And I should see 1 kingdom
    And I should see "Joffre's Kingdom"
    When I toggle the expansions "Dominion, Intrigue" and reload
    And I should see 1 kingdom
    And I should see "Batiatus's Kingdom"

  @search
  Scenario: Browsing a single
    Then I should see "Browsing kingdoms"
    And I should see "Batiatus's Kingdom"
    And I should see "by Batiatus"
    When I follow "Batiatus's Kingdom"
    Then I should see 10 face up cards
    And I should see "Description:"

  @search
  Scenario: Browsing a user's kingdoms
    When I follow "Batiatus"
    Then I should see "Browsing Batiatus's kingdoms"
    And I should see "Batiatus's Kingdom"

  @search
  Scenario: Browsing my kingdoms
    Given there is a kingdom by Joffre
    And I am logged in
    And I wait
    And I am on the home page

    When I follow "My Kingdoms"
    Then I should see "Browsing my kingdoms"
    And I should see "Joffre's Kingdom"
