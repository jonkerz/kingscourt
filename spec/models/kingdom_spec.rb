require "rails_helper"

describe Kingdom do
  describe "validations" do
    it { should validate_presence_of(:name) }

    describe "cards" do
      it "should not allow duplicates" do
        kingdom = build :kingdom
        8.times { kingdom.cards << create(:card) }

        card = create :card
        kingdom.cards << card << card

        expect { kingdom.save }.to raise_error ActiveRecord::RecordNotUnique
      end

      it "must be 10 cards" do
        kingdom = Kingdom.new
        kingdom.save
        expect(kingdom.errors[:cards]).to eq ["must contain 10 cards"]
      end
    end
  end

  describe "#can_be_edited_by?" do
    let!(:creator) { create :user, username: "Creator" }
    let!(:kingdom) { build :kingdom, user: creator }

    it "allows creators to edit their own kingdoms" do
      expect(kingdom.can_be_edited_by? creator).to be true
    end

    it "show not be possible to edit other users' kingdoms" do
      another_user = create :user, username: "OtherUser"
      expect(kingdom.can_be_edited_by? another_user).to be false
    end
  end

  describe "database cleanups" do
    describe "deleting a kingdom" do
      let!(:kingdom) { create_kindom_with_cards }

      it "deletes all kingdom cards (join table)" do
        expect { kingdom.destroy }.to change{KingdomCard.count}.from(10).to(0)
      end

      it "doesn't delete the cards" do
        expect { kingdom.destroy }.not_to change{Card.count}
      end
    end
  end

  describe "#slug" do
    it "slugifies" do
      [ ["Hállå", "halla"],
        ["With spaces, haha!!", "with-spaces--haha"],
        ["p@rty_kingdom", "prty-kingdom"],
        ["12345", "12345"]
      ].each do |no_slug, slugified|
        kingdom = build :kingdom, name: no_slug
        expect(kingdom.slug).to eq slugified
      end
    end
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end

def create_kindom_with_cards
  kingdom = build :kingdom
  10.times { kingdom.cards << create(:card) }
  kingdom.save
  kingdom
end
