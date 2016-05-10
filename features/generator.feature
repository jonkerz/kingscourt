@javascript
Feature: Kingdom generator
  Background:
    Given there are some cards
    And I am on the home page

  Scenario: Generating a kingdom
    And I wait
    Then I should see 10 face down cards
    And I should see 0 face up cards

    When I press "Generate!"
    Then I should see 3 face up cards
    And I should see 7 face down cards

  Scenario: Saving a generated kingdom
    Given I am logged in
    When I press "Generate!"
    When I press "Save Kingdom"
    Then I should see "Messages"
    Then I should see "Saved"
