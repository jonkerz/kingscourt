# Base game
Given /^there is a kingdom by Joffre$/ do
  step 'there are some cards'
  create :kingdom, name: "Joffre's Kingdom",
    cards: [Card.first, Card.second]
end

# Intrigue
Given /^there is a kingdom by Batiatus$/ do
  step 'there are some cards'
  name = "Batiatus"
  create :kingdom, name: "#{name}'s Kingdom",
    user: create(:user, username: name), cards: [Card.last]
end

Then /^I should see (\d+) kingdoms?$/ do |number|
  kingdoms = all ".kingdom-list > li"
  expect(kingdoms.size).to eq number
end

When /^I toggle the expansions "([^"]*)"( and reload)?$/ do |expansions, reload|
  expansions.split(", ").each do |expansion|
    find(".expansion-selector label", text: expansion).click
  end
  find("button", text: "Filter").click if reload
end
