Then /^I should see (\d+) kingdoms?$/ do |number|
  expect(page).to have_selector(".kingdom-list > li", count: number)
end
