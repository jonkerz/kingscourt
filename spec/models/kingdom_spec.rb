require 'rails_helper'

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
