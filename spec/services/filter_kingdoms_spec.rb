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
    context "without filters" do
      let(:params) { {} }

      it "returns all kingdoms" do
        filtered = described_class.new(params, current_user: nil).call

        expect(filtered.results.map(&:name)).to match_array ["Dominion", "Intrigue", "Dominion and Intrigue"]
      end
    end

    context "with filters for Dominon-kingdoms only" do
      let(:params) { { expansions: "1" } }

      specify do
        filtered = described_class.new(params, current_user: nil).call

        expect(filtered.results.map(&:name)).to match_array ["Dominion"]
      end
    end

    context "with filters for Intrigue-kingdoms only" do
      let(:params) { { expansions: "2" } }

      specify do
        filtered = described_class.new(params, current_user: nil).call

        expect(filtered.results.map(&:name)).to match_array ["Intrigue"]
      end
    end

    context "with filters for Dominion, Intrigue and mixed Dominion/Intrigue kingdoms" do
      let(:params) { { expansions: "1,2" } }

      specify do
        filtered = described_class.new(params, current_user: nil).call

        expect(filtered.results.map(&:name)).to match_array ["Dominion", "Intrigue", "Dominion and Intrigue"]
      end
    end

    context "with filters for kingdoms containing Dominion *and* Intrigue cards" do
      let(:params) { { expansions: "1,2", match_all_expansions: "true" } }

      specify do
        filtered = described_class.new(params, current_user: nil).call

        expect(filtered.results.map(&:name)).to match_array ["Dominion and Intrigue"]
      end
    end
  end
end
