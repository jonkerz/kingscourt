Given /^I (?:am on|go to) the home page$/ do
  visit '/'
end

Then /^I should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should not see "([^"]*)"$/ do |text|
  expect(page).to have_no_content(text)
end

When /^I press "([^"]*)"$/ do |link|
  find(:button, text: link).click
end

When /^I wait$/ do
  sleep 1
end

When /^I follow "([^"]*)"$/ do |link|
  click_link link
end

When /^I click on the logout link$/ do
  find("a", text: "Logout").click
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, text|
  fill_in field, with: text
end

When /^I open the "([^"]*)" panel$/ do |title|
  find("h4.panel-title > a", text: title).click
end

When /^I reload the page$/ do
  visit current_path
end
