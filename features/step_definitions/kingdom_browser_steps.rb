# Base game
Given /^there is a kingdom by Joffre$/ do
  build(:kingdom,
    name: "Joffre's Kingdom",
    cards: Card.where(expansion_id: 1).take(10)
  ).save!
end

# Intrigue
Given /^there is a kingdom by Batiatus$/ do
  build(:kingdom,
    name: "Batiatus's Kingdom",
    cards: Card.where(expansion_id: 2).take(10),
    user: create(:user, username: "Batiatus")
  ).save!
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
