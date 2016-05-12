require 'rails_helper'

describe CardType do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
