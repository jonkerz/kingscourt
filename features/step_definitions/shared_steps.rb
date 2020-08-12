Then /^I should see (\d+) face down cards$/ do |number|
  expect(page).to have_css('img[src="randomizer.jpg"]', count: number.to_i)
end

Then /^I should see (\d+) face up cards$/ do |number|
  expect(page).to have_css('img[src="randomizer.jpg"]', count: 10 - number.to_i)
end

When /^I open the "([^"]*)" panel$/ do |title|
  find("h4.panel-title > a", text: title).click
end

When /^I toggle the expansions "([^"]*)"$/ do |expansions|
  expansions.split(", ").each do |expansion|
    find(".expansion-selector label", text: expansion).click
  end
end
