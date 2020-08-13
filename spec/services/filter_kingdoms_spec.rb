require "rails_helper"

describe FilterKingdoms, search: true do
  before :all do
    create_dominion_cards
    create_dominion_kingdom

    create_intrigue_cards
    create_intrigue_kingdom

    create_mixed_dominion_intrigue_kingdom

    Sunspot.commit
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  describe "#call" do
    tests = [
      [
        "all kingdoms",
        {},
        3,
        ["Dominion", "Intrigue", "Dominion and Intrigue"]
      ],

      [
        "Dominon-kingdoms only",
        { expansions: "1" },
        1,
        ["Dominion"]
      ],

      [
        "Intrigue-kingdoms only",
        { expansions: "2" },
        1,
        ["Intrigue"]
      ],

      [
        "Dominion, Intrigue and mixed Dominion/Intrigue kingdoms",
        { expansions: "1,2" },
        3,
        ["Dominion", "Intrigue", "Dominion and Intrigue"]
      ],

      [
        "kingdoms containing Dominion *and* Intrigue cards",
        { expansions: "1,2", match_all_expansions: "true" },
        1,
        ["Dominion and Intrigue"]
      ]
    ]

    # Multiple test due to the expensive setup.
    # TODO: Split into multiple examples.
    tests.each do |description, params, total, kingdom_names|
      it "returns #{description}" do
        filtered = described_class.new(params, current_user: nil).call

        expect(filtered.total).to eq total
        expect(filtered.results.map(&:name).sort).to eq kingdom_names.sort
      end
    end
  end
end
