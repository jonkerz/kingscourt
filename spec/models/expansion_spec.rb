require 'rails_helper'

describe Expansion do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "card attributes" do
    let!(:intrigue) { create :expansion, name: "Intrigue" }
    let!(:is_action) { create :card_attribute, name: "isAction" }
    let!(:is_attack) { create :card_attribute, name: "isAttack" }

    before do
      create :card,
        name: "Mining Village",
        expansion: intrigue,
        card_attributes: [is_action]

      create :card,
        name: "Swindler",
        expansion: intrigue,
        card_attributes: [is_action, is_attack]
    end

    describe "#card_attributes" do
      it "collects all unique card attributes from its cards" do
        expect(intrigue.card_attributes).to eq ["isAction", "isAttack"]
      end
    end

    describe ".all_card_attributes" do
      let!(:dark_ages) { create :expansion, name: "Dark Ages", id: 8 }
      before do
        create :card,
          name: "Urchin",
          expansion: dark_ages,
          card_attributes: [is_attack]
      end

      it "collects card attributes from all expansions" do
        expected = {
          intrigue.id => ["isAction", "isAttack"],
          dark_ages.id => ["isAttack"]
        }
        expect(Expansion.all_card_attributes)
          .to eq expected
      end
    end
  end

  describe "database cleanups" do
    describe "deleting an expansion" do
      let!(:expansion) { create :expansion }
      let!(:card) { create :card, expansion: expansion }

      it "errors out" do
        expect { expansion.destroy }
          .to raise_error ActiveRecord::StatementInvalid
      end

      it "doesn't delete the expansion" do
        expect { expansion.destroy rescue nil }.not_to change{Expansion.count}
      end
    end
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
