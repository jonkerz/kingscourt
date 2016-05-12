require 'rails_helper'

describe Card do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:expansion_id) }
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
