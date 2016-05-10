# TODO add factories
# Base game
Given /^there is a kingdom by Joffre$/ do
  name = "Joffre"
  step %Q[there is a user named "#{name}"]
  step 'there are some cards'
  user = User.find_by(username: name)
  kingdom = Kingdom.create! name: "#{name}'s Kingdom", user: user
  kingdom.cards << Card.first << Card.second
end

# Intrigue
Given /^there is a kingdom by Batiatus$/ do
  name = "Batiatus"
  step %Q[there is a user named "#{name}"]
  step 'there are some cards'
  user = User.find_by(username: name)
  kingdom = Kingdom.create! name: "#{name}'s Kingdom", user: user
  kingdom.cards << Card.last
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
