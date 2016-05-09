@javascript
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

  Scenario: Saving a generated kingdom
    Given I am logged in
    And there are some cards
    When I press "Generate!"
    And I open the "Save Kingdom" panel
    And I wait
    When I press "Save Kingdom"
    Then I should see "Messages"
    Then I should see "Saved"
