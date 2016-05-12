require 'rails_helper'

describe FavoriteKingdom do
  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
