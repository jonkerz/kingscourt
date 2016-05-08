# TODO
module Api::V1
  class KingdomsController < ApiController
    before_action :set_kingdom, only: [:show, :update]
    before_action :authenticate_user!, except: [:index, :show]

    def index
      kingdoms = ActiveModel::ArraySerializer.new(Kingdom.all, each_serializer: KingdomSerializer)
      json = {
        count: 6,
        next: "http://localhost:3000/api/v1/kingdoms/?expansions=2_5_6_7_8_9&page=2",
        previous: nil,
        count_all: 10,
        results: kingdoms
      }
      render json: json
    end

    def show
      render json: @kingdom
    end

    def create
      kingdom = Kingdom.new kingdom_params
      kingdom.user = current_user || User.second
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
