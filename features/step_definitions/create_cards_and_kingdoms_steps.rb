Given /^there are some Dominion cards$/ do
  create_dominion_cards
end

Given /^there are some Intrigue cards$/ do
  create_intrigue_cards
end

Given /^there is a Dominion kingdom(?: by Joffre)$/ do
  name = "Joffre's Dominion Kingdom"
  create_dominion_kingdom name: name
end

Given /^there is an Intrigue kingdom(?: by Batiatus)?$/ do
  name = "Batiatus's Intrigue Kingdom"
  create_intrigue_kingdom name: name
end

Given /^there is a mixed Dominion\/Intrigue kingdom$/ do
  name = "Mixed Dominion and Intrigue Kingdom"
  create_mixed_dominion_intrigue_kingdom name: name
end

Given /^there are (\d+) kingdoms?$/ do |number|
  standard = Expansion.find_by!(name: "Dominion")
  cards = standard.cards.take(10)

  number.times do |n|
    build(:kingdom, name: "Kingdom #{n}", cards: cards).save!
  end
end
