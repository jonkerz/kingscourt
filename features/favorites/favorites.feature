@javascript
Feature: Favorites
  Background:
    Given I am logged in
    And there is a kingdom by Joffre
    And there is a kingdom by Batiatus
    And I am on the home page
    And I follow "Browse Kingdoms"

  Scenario: Favoriting from the browser
    Then I should not see "Joffre's Kingdom" favorited
    And I should not see "Batiatus's Kingdom" favorited

    When I favorite "Joffre's Kingdom"
    Then I should see "Joffre's Kingdom" favorited

    When I reload the page
    And I follow "Browse Kingdoms"
    Then I should see "Joffre's Kingdom" favorited
    And I should not see "Batiatus's Kingdom" favorited

  Scenario: Browsing my favorites
    Given PENDING
    When I click on my username in the navbar
    And I follow "Favorites"
    Then I should see "Browsing Joffre's favorite kingdoms"
    And I should see "Joffre's Kingdom" favorited
    And I should not see "Batiatus's Kingdom" favorited