module Api::V1
  class FavoritesController < ApiController
    before_action :authenticate_user!

    def create
      kingdom = Kingdom.find(params[:kingdom_id])
      kingdom.favoriters << current_user
      render json: :created
    end

    def destroy
      kingdom = Kingdom.find(params[:id])
      kingdom.favoriters.delete current_user
      render json: :no_content
    end
  end
end
