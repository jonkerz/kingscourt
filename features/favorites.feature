@javascript
Feature: Favorites
  Background:
    Given there are some Dominion cards
    And there are some Intrigue cards
    And there is a Dominion kingdom by Joffre
    And there is an Intrigue kingdom by Batiatus
    And I am logged in
    And I follow "Browse Kingdoms"

  @search
  Scenario: Favoriting from the browser
    Then I should not see "Joffre's Dominion Kingdom" favorited
    And I should not see "Batiatus's Intrigue Kingdom" favorited

    When I favorite "Joffre's Dominion Kingdom"
    Then I should see "Joffre's Dominion Kingdom" favorited

    When I reload the page
    And I follow "Browse Kingdoms"
    Then I should see "Joffre's Dominion Kingdom" favorited
    And I should not see "Batiatus's Intrigue Kingdom" favorited

  @search
  Scenario: Browsing my favorites
    When I favorite "Joffre's Dominion Kingdom"
    # TODO: Use waiting matcher.
    And WAIT
    And I click on my username in the navbar
    And I follow "Favorites"
    Then I should see "Browsing my favorite kingdoms"
    And I should see "Joffre's Dominion Kingdom" favorited
    And I should not see "Batiatus's Intrigue Kingdom"

  @search
  Scenario: Browsing another user's favorites
    Given Batiatus has favorited his own kingdom

    When I go to Batiatus' favorite kingdoms page
    Then I should see "Browsing Batiatus's favorite kingdoms"
    And I should see "Batiatus's Intrigue Kingdom"
    And I should not see "Joffre's Dominion Kingdom"
