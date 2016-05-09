Then /^I should see (\d+) face down cards$/ do |number|
  expect(facedown_cards.size).to eq number
end

Then /^I should see (\d+) face up cards$/ do |number|
  cards = all ".card-border-radius"
  facedown = facedown_cards
  expect(cards.size - facedown_cards.size).to eq number
end

Given /^there are some cards$/ do # TODO factory
  unless Card.exists? 2
    Card.create id: 2, name: "Chapel", randomizable: true,
    text: "Trash up to 4 cards from your hand.",
    expansion_id: 0, card_type_id: 0
  end

  unless Card.exists? 11
    Card.create id: 11, name: "Militia", randomizable: true,
    text: "+$2<br />Each other player discards...",
    expansion_id: 0, card_type_id: 2
  end

  unless Card.exists? 30
    Card.create id: 30, name: "Masquerade", randomizable: true,
    text: "+2 Cards<br />Each player passes a...",
    expansion_id: 1, card_type_id: 0
  end
end

def facedown_cards
  all :xpath, "//img[contains(@src, 'Randomizer.jpg')]"
end

Transform /(^-?\d+$)/ do |str|
  str.to_i
end
