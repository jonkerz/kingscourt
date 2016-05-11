require 'rails_helper'

describe Kingdom do
  describe "validations" do
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
end
