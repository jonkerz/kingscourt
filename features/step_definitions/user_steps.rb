Then /^I should not see the login modal$/ do
  expect(page).to have_no_css(".modal-content")
end

Then /^I should see the login modal$/ do
  expect(page).to have_css(".modal-content")
end

Given /^there is a user$/ do
  User.create email: "king@example.com",
    password: "secret123", name: "Joffre"
end

Given /^I am logged in$/ do # TODO
  step 'there is a user'
  step 'I am on the home page'
  step 'I follow "Login/Register"'
  step 'I fill in "login-email" with "king@example.com"'
  step 'I fill in "login-password" with "secret123"'
  step 'I press "Login"'
end

When(/^I click outside of the modal$/) do
  first(".modal").click
end

Then(/^I should be logged in$/) do
  expect(page).to have_content("My Kingdoms")
end
