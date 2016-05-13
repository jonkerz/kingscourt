Then /^I should see (\d+) kingdoms?$/ do |number|
  kingdoms = all ".kingdom-list > li"
  expect(kingdoms.size).to eq number
end
