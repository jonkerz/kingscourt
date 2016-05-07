Feature: Kingdom generator
  Background:
    Given I am on the home page

  Scenario: Generating a kingdom
    And I wait
    Then I should see 10 face down cards
    And I should see 0 face up cards

    When I press "Generate!"
    Then I should see 10 face up cards
    And I should see 0 face down cards
