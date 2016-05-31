Then /^I should see (\d+) kingdoms?$/ do |number|
  expect(page).to have_selector(".kingdom-list > li", count: number)
end

When /^I press Filter$/ do
  find("button", text: "Filter").click
end

When /^I filter with "match all expansion"$/ do
  find("label", text: "Match all expansions?").click
end
