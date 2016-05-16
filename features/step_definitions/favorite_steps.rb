Then /^I should (not )?see "([^"]*)" favorited$/ do |favorited, kingdom_name|
  star = star_next_to kingdom_name
  expect(favorited? star).to eq !favorited
end

When /^I favorite "([^"]*)"$/ do |kingdom_name|
  star = star_next_to kingdom_name
  star.click
end

Given /^Batiatus has favorited his own kingdom$/ do
  user = User.find_by username: "Batiatus"
  create :favorite_kingdom, user: user,
    kingdom: user.kingdoms.first
end

When /^I go to Batiatus' favorite kingdoms page$/ do
  visit "/#!/Batiatus/favorites"
end

def star_next_to kingdom_name
  element = find ".list-group-item a", text: kingdom_name
  element.find(:xpath, '..').find(:button)
end

def favorited? star
  !star.find("span")[:class]["fa-star-o"]
end