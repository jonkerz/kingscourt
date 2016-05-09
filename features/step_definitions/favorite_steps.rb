Then /^I should (not )?see "([^"]*)" favorited$/ do |favorited, kingdom_name|
  star = star_next_to kingdom_name
  expect(is_favorited? star).to eq !favorited
end

When /^I favorite "([^"]*)"$/ do |kingdom_name|
  star = star_next_to kingdom_name
  star.click
end

def star_next_to kingdom_name
  element = find ".list-group-item a", text: kingdom_name
  element.find(:xpath, '..').find(:button)
end

def is_favorited? star
  !star.find("span")[:class]["fa-star-o"]
end