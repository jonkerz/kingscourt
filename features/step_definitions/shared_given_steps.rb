Given /^there are some cards$/ do
  %w(Cellar Chapel Moat Chancellor Village
    Woodcutter Workshop Bureaucrat Feast Gardens
  ).each do |name|
    create :card, name: name, expansion_id: 1
  end

  %w(Courtyard Pawn Secret\ Chamber Great\ Hall Masquerade
    Shanty\ Town Steward Swindler Wishing\ Well Baron
  ).each do |name|
    create :card, name: name, expansion_id: 2
  end
end

# Base game
Given /^there is a kingdom by Joffre$/ do
  build(:kingdom,
    name: "Joffre's Kingdom",
    description: "Very dangerous kingdom.",
    cards: Card.where(expansion_id: 1).take(10)
  ).save!
end

# Intrigue
Given /^there is a kingdom by Batiatus$/ do
  build(:kingdom,
    name: "Batiatus's Kingdom",
    cards: Card.where(expansion_id: 2).take(10),
    user: create(:user, username: "Batiatus")
  ).save!
end
