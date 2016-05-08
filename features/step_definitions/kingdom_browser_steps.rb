# TODO add factories
Given(/^there is a kingdom$/) do
  step 'there is a user'
  step 'the are some cards [TODO]'
  user = User.first
  kingdom = Kingdom.create! name: "Dangerous Kingdom", user: user
  kingdom.cards << Card.first << Card.second
end
