@javascript
Feature: Kingdom browser
  Background:
    Given there are some cards
    And there is a kingdom by Batiatus
    And I am on the home page
    And I follow "Browse Kingdoms"

  @search
  Scenario: Browsing all kingdoms
    Given there is a kingdom by Joffre
    And I am on the home page
    And I follow "Browse Kingdoms"

    Then I should see "Browsing kingdoms"
    And I should see 2 kingdoms
    And I should see "Joffre's Kingdom"
    And I should see "Batiatus's Kingdom"

  @search
  Scenario: Browsing all kingdoms (page 2 via GUI)
    Given there are 5 kingdoms
    And I am on the home page
    And I follow "Browse Kingdoms"

    Then I should see "Browsing kingdoms (6)"
    And I should see 5 kingdoms

    When I follow "2"
    Then I should see 1 kingdom

  @search
  Scenario: Browsing all kingdoms (page 2 via URL params)
    Given there are 5 kingdoms
    And I follow "Cards"

    When I go to "/#!/kingdoms?page=2"
    Then I should see "Browsing kingdoms (6)"
    And I should see 1 kingdom

  @search
  Scenario: Filtering kingdoms
    Given there is a kingdom by Joffre
    And there is a kingdom by mixed kingdom
    And I am on the home page

    When I follow "Browse Kingdoms"
    Then I should see "Browsing kingdoms (3)"
      And I should see 3 kingdoms

    When I toggle the expansions "Intrigue"
      And I press Filter
    Then I should see 1 kingdom
      And I should see "Joffre's Kingdom"

    When I toggle the expansions "Dominion, Intrigue"
      And I press Filter
    Then I should see 1 kingdoms
      And I should see "Batiatus's Kingdom"

    When I filter with "match all expansion"
      And I toggle the expansions "Dominion, Seaside, Alchemy, Prosperity, Cornucopia, Hinterlands, Dark Ages, Guilds, Adventures, Promo"
      And I press Filter
    Then I should see 1 kingdoms
      And I should see "Mixed Dominion and Intrigue Kingdom"

  @search
  Scenario: Filtering kingdoms (from URL params)
    Given there is a kingdom by Joffre
    And I am on the home page

    When I go to "/#!/kingdoms?expansions=1"
    Then I should see "Browsing kingdoms (1)"
      And I should see 1 kingdoms
      And I should see "Joffre's Kingdom"

  @search
  Scenario: Filtering kingdoms (match_all_expansions, URL params)
    Given there is a kingdom by Joffre
    And there is a kingdom by mixed kingdom
    And I am on the home page

    When I go to "/#!/kingdoms?expansions=1,2&match_all_expansions=true"
    Then I should see "Browsing kingdoms (1)"
      And I should see 1 kingdoms
      And I should see "Mixed Dominion and Intrigue Kingdom"

  @search
  Scenario: Browsing a single kingdom
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
