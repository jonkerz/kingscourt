@javascript
Feature: Kingdom generator
  Background:
    Given there are some Dominion cards
    And I am on the home page

  Scenario: Generating a kingdom and opening it in the builder
    Then I should see 10 face down cards
    And I should see 0 face up cards

    When I press "Generate!"
    Then I should see 10 face up cards
    And I should see 0 face down cards

    When I press "Open in Builder"
    Then I should be on "!/builder"

  Scenario: Saving a generated kingdom
    Given I am logged in

    When I press "Generate!"
    And I open the "Save Kingdom" panel
    And I fill in "kingdom-name" with "My First Kingdom"
    And I fill in "kingdom-description" with "Advanced stuff"
    And I press "Save Kingdom"
    Then I should see "Successfully saved My First Kingdom"

    When I follow "My First Kingdom"
    Then I should see "My First Kingdom"
    And I should see "Advanced stuff"
    And I should see "Added by Joffre"
