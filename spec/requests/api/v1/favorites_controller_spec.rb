require "rails_helper"

describe Api::V1::FavoritesController do
  describe "POST /api/v1/u/:username/favorites/:kingdom_id" do
    let!(:kingdom) { create :kingdom, :without_cards }
    let!(:user) { create :user }

    context "when not signed" do
      it "does not favorite the kingdom" do
        expect do
          post "/api/v1/u/#{user.username}/favorites", params: { kingdom_id: kingdom.id }
        end.to_not change { FavoriteKingdom.count }
      end
    end

    context "when signed in" do
      let!(:user) { create :user }

      it "favorites the kingdom" do
        expect do
          post "/api/v1/u/#{user.username}/favorites", params: { kingdom_id: kingdom.id }, headers: auth_headers_for(user)
        end.to change { user.reload.favorites }.from([]).to([kingdom])
      end
    end
  end

  describe "DELETE /api/v1/u/:username/favorites/:id" do
    let!(:kingdom) { create :kingdom, :without_cards }
    let!(:user) { create :user }
    let!(:favorite_kingdom) { create :favorite_kingdom, user: user, kingdom: kingdom }

    context "when signed in as the favoriter" do
      it "unfavorites the kingdom" do
        expect do
          delete "/api/v1/u/#{user.username}/favorites/#{kingdom.id}", headers: auth_headers_for(user)
        end.to change { user.reload.favorites }.from([kingdom]).to([])
      end
    end

    context "when not signed in as the favoriter" do
      let!(:another_user) { create :user, username: "another_user" }

      it "does not unfavorite the kingdom" do
        expect do
          delete "/api/v1/u/#{user.username}/favorites/#{kingdom.id}", headers: auth_headers_for(another_user)
        end.to_not change { FavoriteKingdom.count }
      end
    end
  end
end
