Then /^I should see (\d+) face down cards$/ do |number|
  expect(page).to have_css('img[src="randomizer.jpg"]', count: number)
end

Then /^I should see (\d+) face up cards$/ do |number|
  expect(page).to have_css('img[src="randomizer.jpg"]', count: 10 - number)
end
