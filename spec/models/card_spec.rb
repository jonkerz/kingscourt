require 'rails_helper'

describe Card do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:expansion_id) }
  end
end
