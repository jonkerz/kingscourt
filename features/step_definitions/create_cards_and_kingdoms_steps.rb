Given /^there are some Dominion cards$/ do
  standard = create :expansion, name: "Dominion", id: 1

  %w(Cellar Chapel Moat Chancellor Village
    Woodcutter Workshop Bureaucrat Feast Gardens).each do |name|
    create :card, name: name, expansion: standard
  end
end

Given /^there are some Intrigue cards$/ do
  intrigue = create :expansion, name: "Intrigue", id: 2

  %w(Courtyard Pawn Secret\ Chamber Great\ Hall Masquerade
    Shanty\ Town Steward Swindler Wishing\ Well Baron).each do |name|
    create :card, name: name, expansion: intrigue
  end
end

Given /^there is a Dominion kingdom(?: by Joffre)$/ do
  standard = Expansion.find_by!(name: "Dominion")

  build(:kingdom,
    name: "Joffre's Dominion Kingdom",
    description: "Very dangerous kingdom.",
    cards: standard.cards.take(10)).save!
end

Given /^there is an Intrigue kingdom(?: by Batiatus)?$/ do
  intrigue = Expansion.find_by!(name: "Intrigue")

  build(:kingdom,
    name: "Batiatus's Intrigue Kingdom",
    cards: intrigue.cards.take(10),
    user: create(:user, username: "Batiatus")).save!
end

Given /^there is a mixed Dominion\/Intrigue kingdom$/ do
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
