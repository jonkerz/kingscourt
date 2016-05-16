require "rails_helper"

describe CardType do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "database cleanups" do
    describe "deleting a card type" do
      let!(:action) { create :card_type, name: "Action" }
      let!(:card) { create :card, card_type: action }

      it "errors out" do
        expect { action.destroy }.to raise_error ActiveRecord::StatementInvalid
      end

      it "doesn't delete the card type" do
        expect { action.destroy rescue nil }.not_to change{CardType.count}
      end
    end
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
