# TODO add factories
Given(/^there is a kingdom by "([^"]*)"$/) do |name|
  step %Q[there is a user named "#{name}"]
  step 'the are some cards [TODO]'
  user = User.find_by(username: name)
  kingdom = Kingdom.create! name: "#{name}'s Kingdom", user: user
  kingdom.cards << Card.first << Card.second
end

Then /^I should see (\d+) kingdoms$/ do |number|
  kingdoms = all ".kingdom-list > li"
  expect(kingdoms.size).to eq number
end
