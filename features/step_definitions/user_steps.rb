Then /^I should not see the login modal$/ do
  expect(page).to have_no_css(".modal-content")
end

Then /^I should see the login modal$/ do
  expect(page).to have_css(".modal-content")
end
