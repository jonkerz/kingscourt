# TODO

module Api::V1
  class FavoritesController < ApiController
    before_action :authenticate_user!, except: [:index]

    def index # TODO
      raise NotImplementedError
      user = User.first
      favorites = FavoriteKingdom.where(user: user).pluck :id
      render json: favorites
    end

    def create # TODO
      kingdom = Kingdom.find(params[:kingdom_id])
      FavoriteKingdom.create! user: current_user,
        kingdom: kingdom
      render json: :ok
    end

    def destroy # TODO
      id = params[:id]
      FavoriteKingdom.find_by(kingdom_id: id, user: current_user).destroy
      render json: :ok
    end
  end
end
