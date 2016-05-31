Given /^there are some cards$/ do
  standard = create :expansion, name: "Dominion", id: 1
  intrigue = create :expansion, name: "Intrigue", id: 2

  %w(Cellar Chapel Moat Chancellor Village
    Woodcutter Workshop Bureaucrat Feast Gardens).each do |name|
    create :card, name: name, expansion: standard
  end

  %w(Courtyard Pawn Secret\ Chamber Great\ Hall Masquerade
    Shanty\ Town Steward Swindler Wishing\ Well Baron).each do |name|
    create :card, name: name, expansion: intrigue
  end
end

# Base game
Given /^there is a kingdom by Joffre$/ do
  standard = Expansion.find_by!(name: "Dominion")

  build(:kingdom,
    name: "Joffre's Kingdom",
    description: "Very dangerous kingdom.",
    cards: standard.cards.take(10)).save!
end

# Intrigue
Given /^there is a kingdom by Batiatus$/ do
  intrigue = Expansion.find_by!(name: "Intrigue")

  build(:kingdom,
    name: "Batiatus's Kingdom",
    cards: intrigue.cards.take(10),
    user: create(:user, username: "Batiatus")).save!
end

# Mixed base game and Intrigue
Given /^there is a kingdom by mixed kingdom$/ do
  standard = Expansion.find_by!(name: "Dominion")
  intrigue = Expansion.find_by!(name: "Intrigue")

  cards = standard.cards.take(5) + intrigue.cards.take(5)

  build(:kingdom,
    name: "Mixed Dominion and Intrigue Kingdom",
    cards: cards,
    user: create(:user, username: "Batiatus")).save!
end

Given /^there are (\d+) kingdoms?$/ do |number|
  standard = Expansion.find_by!(name: "Dominion")
  cards = standard.cards.take(10)

  number.times do |n|
    build(:kingdom, name: "Kingdom #{n}", cards: cards).save!
  end
end

Transform /(^-?\d+$)/ do |str|
  str.to_i
end
