require "rails_helper"

describe KingdomCard do
  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
