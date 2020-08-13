require "rails_helper"

describe Api::V1::KingdomsController do
  describe "PUT /api/v1/kingdoms" do
    let!(:kingdom) do
      create_dominion_cards
      create_dominion_kingdom

      Kingdom.last # TODO: Hmm.
    end
    let!(:params) do
      {
        card_ids: kingdom.card_ids,
        name: 'new name'
      }
    end
    let!(:user) { create :user }

    context "when not signed" do
      it "does not update the kingdom" do
        expect do
          put "/api/v1/kingdoms/#{kingdom.id}", params: params
        end.to_not change { kingdom.reload.name }
        expect(json_response).to eq "forbidden"
      end
    end

    context "when signed in" do
      let!(:user) { create :user }

      it 'updates the kingdom' do
        expect do
          put "/api/v1/kingdoms/#{kingdom.id}", params: params, headers: auth_headers_for(user)
        end.to change { kingdom.reload.name }.to(params[:name])
      end
    end
  end

  describe "DELETE /api/v1/kingdoms/:id" do
    let!(:kingdom) { create :kingdom, :without_cards }

    context "when not signed in" do
      it "does not delete the kingdom" do
        expect do
          delete "/api/v1/kingdoms/#{kingdom.id}"
        end.to_not change { Kingdom.count }
        expect(json_response).to eq "forbidden"
      end
    end

    context "when signed in as the owner" do
      it "deletes the kingdom" do
        expect do
          delete "/api/v1/kingdoms/#{kingdom.id}", headers: auth_headers_for(kingdom.user)
        end.to change { Kingdom.count }
      end
    end

    context "when not signed in as the owner" do
      let!(:another_user) { create :user, username: "another_user" }

      it "does not delete the kingdom" do
        expect do
          delete "/api/v1/kingdoms/#{kingdom.id}", headers: auth_headers_for(another_user)
        end.to_not change { Kingdom.count }
        expect(json_response).to eq "forbidden"
      end
    end
  end
end
