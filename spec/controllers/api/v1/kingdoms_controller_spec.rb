require "rails_helper"

describe Api::V1::KingdomsController, search: true do
  describe "#filter_kingdoms" do
    before do
      there_are_some_dominion_cards
      there_are_some_intrigue_cards
      there_is_a_dominion_kingdom
      there_is_an_intrigue_kingdom
      there_is_a_mixed_dominion_intrigue_kingdom
      Sunspot.commit
    end

    # Multiple test due to the expensive setup.
    it "filters by expansion" do
      [
        [ {},
          3,
          ["Dominion", "Intrigue", "Dominion and Intrigue"] ],
        [ { expansions: "1" },
          1,
          ["Dominion"] ],
        [ { expansions: "2" },
          1,
          ["Intrigue"] ],
        [ { expansions: "1,2" },
          3,
          ["Dominion", "Intrigue", "Dominion and Intrigue"] ],
        [ { expansions: "1,2", match_all_expansions: "true" },
          1,
          ["Dominion and Intrigue"] ]
      ].each do |params, total, kingdom_names|
        filtered = controller.send :filter_kingdoms, params

        expect(filtered.total).to eq total
        expect(filtered.results.map(&:name).sort).to eq kingdom_names.sort
      end
    end
  end
end

# TODO: NUKE. Copied from Cucumber.
def there_are_some_dominion_cards
  standard = create :expansion, name: "Dominion", id: 1

  %w(Cellar Chapel Moat Chancellor Village
    Woodcutter Workshop Bureaucrat Feast Gardens).each do |name|
    create :card, name: name, expansion: standard
  end
end

def there_are_some_intrigue_cards
  intrigue = create :expansion, name: "Intrigue", id: 2

  %w(Courtyard Pawn Secret\ Chamber Great\ Hall Masquerade
    Shanty\ Town Steward Swindler Wishing\ Well Baron).each do |name|
    create :card, name: name, expansion: intrigue
  end
end

def there_is_a_dominion_kingdom
  standard = Expansion.find_by!(name: "Dominion")

  build(:kingdom,
    name: "Dominion",
    description: "Very dangerous kingdom.",
    cards: standard.cards.take(10)).save!
end

def there_is_an_intrigue_kingdom
  intrigue = Expansion.find_by!(name: "Intrigue")

  build(:kingdom,
    name: "Intrigue",
    cards: intrigue.cards.take(10),
    user: create(:user, username: "Batiatus")).save!
end

def there_is_a_mixed_dominion_intrigue_kingdom
  standard = Expansion.find_by!(name: "Dominion")
  intrigue = Expansion.find_by!(name: "Intrigue")

  cards = standard.cards.take(5) + intrigue.cards.take(5)

  build(:kingdom,
    name: "Dominion and Intrigue",
    cards: cards,
    user: create(:user, username: "Batiatus")).save!
end
