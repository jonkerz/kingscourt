Then /^I should see (\d+) face down cards$/ do |number|
  expect(facedown_cards.size).to eq number
end

Then /^I should see (\d+) face up cards$/ do |number|
  cards = all ".card-border-radius"
  facedown = facedown_cards
  expect(cards.size - facedown_cards.size).to eq number
end

def facedown_cards
  all :xpath, "//img[contains(@src, 'Randomizer.jpg')]"
end

Transform /(^-?\d+$)/ do |str|
  str.to_i
end
