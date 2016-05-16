Given /^there are some cards$/ do
  standard = create :expansion, name: "Dominion", id: 1
  intrigue = create :expansion, name: "Intrigue", id: 2

  %w(Cellar Chapel Moat Chancellor Village
    Woodcutter Workshop Bureaucrat Feast Gardens
  ).each do |name|
    create :card, name: name, expansion: standard
  end

  %w(Courtyard Pawn Secret\ Chamber Great\ Hall Masquerade
    Shanty\ Town Steward Swindler Wishing\ Well Baron
  ).each do |name|
    create :card, name: name, expansion: intrigue
  end
end

# Base game
Given /^there is a kingdom by Joffre$/ do
  standard = Expansion.find_by!(name: "Dominion")

  build(:kingdom,
    name: "Joffre's Kingdom",
    description: "Very dangerous kingdom.",
    cards: Card.where(expansion: standard).take(10)
  ).save!
end

# Intrigue
Given /^there is a kingdom by Batiatus$/ do
  intrigue = Expansion.find_by!(name: "Intrigue")

  build(:kingdom,
    name: "Batiatus's Kingdom",
    cards: Card.where(expansion: intrigue).take(10),
    user: create(:user, username: "Batiatus")
  ).save!
end
