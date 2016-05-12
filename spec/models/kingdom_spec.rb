require 'rails_helper'

describe Kingdom do
  describe "validations" do
    it { should validate_presence_of(:name) }

    describe "disallow card duplicates" do
      let(:card) { create :card }
      let(:kingdom) { create :kingdom }

      it "should not be allowed" do
        kingdom.cards << card
        expect { kingdom.cards << card }
          .to raise_error ActiveRecord::RecordNotUnique
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
        kingdom = create :kingdom, name: no_slug
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
