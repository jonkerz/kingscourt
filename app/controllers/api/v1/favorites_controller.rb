module Api::V1
  class FavoritesController < ApiController
    before_action :authenticate_user!

    def create
      kingdom = Kingdom.find(params[:kingdom_id])
      FavoriteKingdom.create! user: current_user,
        kingdom: kingdom
      render json: :ok
    end

    def destroy
      id = params[:id]
      FavoriteKingdom.find_by(kingdom_id: id, user: current_user).destroy
      render json: :ok
    end
  end
end
