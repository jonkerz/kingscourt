require "rails_helper"

describe User do
  describe "validations" do
    subject { create :user }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_length_of(:username).is_at_least(3).is_at_most(25) }

    it { is_expected.to allow_value("user-name._1").for(:username) }
    it { is_expected.to_not allow_value("^username").for(:username) }
    it { is_expected.to_not allow_value("usernäme").for(:username) }
  end

  describe "versioning" do
    with_versioning do
      it { is_expected.to be_versioned }
    end
  end
end
