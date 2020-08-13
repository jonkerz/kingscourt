require "rails_helper"

describe Api::V1::CardsController do
  describe "GET /api/v1/cards" do
    before do
      create :card, name: "Cellar"
      create :card, name: "Chapel"
      create :card, name: "Estate", randomizable: false
    end

    context "without params" do
      it "returns all cards" do
        get "/api/v1/cards"

        expect(response).to have_http_status :success
        expect(json_response.size).to eq 3
        expect(card_names).to eq ["Cellar", "Chapel", "Estate"]
      end
    end

    context "with param `randomizable=true`" do
      it "returns randomizable cards only" do
        get "/api/v1/cards?randomizable=true"

        expect(response).to have_http_status :success
        expect(json_response.size).to eq 2
        expect(card_names).to eq ["Cellar", "Chapel"]
      end
    end

    context "with param `randomizable=false`" do
      it "returns non-randomizable cards only" do
        get "/api/v1/cards?randomizable=false"

        expect(response).to have_http_status :success
        expect(json_response.size).to eq 1
        expect(card_names).to eq ["Estate"]
      end
    end
  end

  def card_names
    json_response.map { |card| card["name"] }
  end
end
