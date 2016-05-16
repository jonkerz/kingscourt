require "rails_helper"

describe CardAttribute do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "database cleanups" do
    describe "deleting a card attribute" do
      let!(:is_action) { create :card_attribute, name: "isAction" }
      let!(:card) do
        is_attack = create :card_attribute, name: "isAttack"
        card = create :card
        card.card_attributes << is_action << is_attack
        card
      end

      it "removed itself from cards" do
        expect { is_action.destroy }
          .to change{card.card_attributes.count}.from(2).to(1)
      end
    end
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
