Then /^I should not see the login modal$/ do
  expect(page).to have_no_css(".modal-content")
end

Then /^I should see the login modal$/ do
  expect(page).to have_css(".modal-content")
end

Given(/^there is a user$/) do
  User.create email: "king@example.com", password: "secret123"
end

When(/^I click outside of the modal$/) do
  first(".modal").click
end

Then(/^I should be logged in$/) do
  expect(page).to have_content("My Kingdoms")
end
