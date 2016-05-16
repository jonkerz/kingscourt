require 'rails_helper'

describe Card do
  describe "scopes" do
    let!(:action) { create :card }
    let!(:attack) { create :card }
    let!(:victory) { create :card, randomizable: false }

    describe ".randomizers" do
      it "return randomizable cards only" do
        expect(Card.randomizers).to eq [action, attack]
      end
    end
    describe ".non_randomizers" do
      it "return non-randomizable cards only" do
        expect(Card.non_randomizers).to eq [victory]
      end
    end
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:expansion_id) }

    describe "card_attributes" do
      let(:card) { create :card }
      let(:is_duplicate) { create :card_attribute, name: "isDuplicate" }

      it "should not allow duplicates" do
        expect { card.card_attributes << is_duplicate << is_duplicate }
          .to raise_error ActiveRecord::RecordNotUnique
      end
    end
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
