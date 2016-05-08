# TODO

module Api::V1
  class KingdomsController < ApiController
    before_action :set_kingdom, only: [:show, :update]
    before_action :authenticate_user!, except: [:index, :show]
    include CleanPagination

    def index
      kingdoms = if params[:username]
                  user = User.find_by(name: params[:username])
                  Kingdom.where(user: user)
                else
                  Kingdom.all
                end

      max_per_page = 100
      paginate kingdoms.count, max_per_page do |limit, offset|
        render json: kingdoms.limit(limit).offset(offset)
      end
    end

    def show
      render json: @kingdom
    end

    def create
      kingdom = Kingdom.new kingdom_params
      kingdom.user = current_user
      kingdom.card_ids = params[:card_ids]
      kingdom.save!
      render json: :ok
     end

    def update
      @kingdom.update! kingdom_params
      render json: :ok
    end

    private
      def set_kingdom
        @kingdom = Kingdom.find params[:id]
      end

      def kingdom_params
        params.permit :name, :card_ids, :description, :name
      end
  end
end
