require 'rails_helper'

describe Expansion do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
