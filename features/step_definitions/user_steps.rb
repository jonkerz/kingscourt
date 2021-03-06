Then /^I should not see the login modal$/ do
  expect(page).to have_no_css(".modal-content")
end

Then /^I should see the login modal$/ do
  expect(page).to have_css(".modal-content")
end

Given /^there is a user(?: named "([^"]+)")?$/ do |username|
  if username
    create :user, username: username
  else
    create :user
  end
end

Given /^I am logged in$/ do
  create :user
  step "I am on the home page"
  step "I login in via the web interface"
end

When /^I login in via the web interface$/ do
  step 'I follow "Login/Register"'
  step 'I fill in "login-email" with "joffre@example.com"'
  step 'I fill in "login-password" with "secret123"'
  step 'I press "Login"'
end

When /^I click outside of the modal$/ do
  find(".modal").click
end

Then /^I should (?:|still )be logged in$/ do
  expect(page).to have_content("My Kingdoms")
end

Then /^I should not be logged in$/ do
  expect(page).to have_no_content("My Kingdoms")
end

When /^I click on my username in the navbar$/ do
  find(".dropdown").click
end
