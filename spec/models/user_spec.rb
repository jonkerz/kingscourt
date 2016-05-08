require 'rails_helper'

describe User do
  describe "validations" do
    subject { build_user }

    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).
      is_at_least(3).is_at_most(25) }

    it { should allow_value('user-name._1').for(:username) }
    it { should_not allow_value('^username').for(:username) }
    it { should_not allow_value('usernäme').for(:username) }
  end
end

def build_user
  User.new email: "king@example.com",
    password: "secret123",
    username: "Joffre"
end
