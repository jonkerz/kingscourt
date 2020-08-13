require "rails_helper"

describe Api::V1::ExpansionsController do
  describe "GET /api/v1/expansions" do
    let!(:expansion) { create :expansion }
    let!(:is_action) { create :card_attribute, name: "isAction" }
    let!(:card) { create :card, name: "Cellar", expansion: expansion, card_attributes: [is_action] }

    context 'with param `card_attributes`' do
      it "returns card attributes grouped by expansion" do
        get "/api/v1/expansions", params: { card_attributes: 'y' }

        expect(json_response).to eq(
          expansion.id.to_s => [is_action.name]
        )
        expect(response).to have_http_status :success
      end
    end
  end
end
