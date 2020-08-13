require "rails_helper"

describe "CardsController" do
  describe "#index" do
    before do
      create :card, name: "Cellar"
      create :card, name: "Chapel"
      create :card, name: "Estate", randomizable: false
      get group_description
    end

    describe "/api/v1/cards" do
      it "returns all cards" do
        expect(response).to have_http_status :success
        expect(json.size).to eq 3
        expect(card_names).to eq ["Cellar", "Chapel", "Estate"]
      end
    end

    describe "/api/v1/cards?randomizable=true" do
      it "returns randomizable cards only" do
        expect(response).to have_http_status :success
        expect(json.size).to eq 2
        expect(card_names).to eq ["Cellar", "Chapel"]
      end
    end

    describe "/api/v1/cards?randomizable=false" do
      it "returns non-randomizable cards only" do
        expect(response).to have_http_status :success
        expect(json.size).to eq 1
        expect(card_names).to eq ["Estate"]
      end
    end
  end

end

def card_names
  json.map { |card| card["name"] }
end
