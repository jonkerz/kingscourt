require 'rails_helper'

describe CardType do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
