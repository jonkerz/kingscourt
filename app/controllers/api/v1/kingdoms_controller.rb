module Api::V1
  class KingdomsController < ApiController
    before_action :set_kingdom, only: [:show, :update, :destroy]
    before_action :check_can_be_edited_by, only: [:update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
      kingdoms = FilterKingdoms.new(params, current_user: current_user).call

      expansion_facets = {}
      kingdoms.facet(:expansion_ids).rows.each do |row|
        expansion_facets[row.value] = row.count
      end

      render json: kingdoms.results,
        root: "kingdoms",
        meta: {
          count: kingdoms.total,
          expansion_facets: expansion_facets
        }
    end

    def show
      render json: @kingdom
    end

    def create
      kingdom = Kingdom.new kingdom_params
      kingdom.user = current_user
      kingdom.card_ids = params[:card_ids]

      if kingdom.save
        render json: kingdom, status: :created
      else
        json = { errors: kingdom.errors.full_messages.join(", ") }
        render json: json, status: :unprocessable_entity
      end
    end

    def update
      @kingdom.card_ids = params[:card_ids]
      if @kingdom.update kingdom_params
        render json: @kingdom, status: :ok
      else
        json = { errors: @kingdom.errors.full_messages.join(", ") }
        render json: json, status: :unprocessable_entity
      end
    end

    def destroy
      if @kingdom.destroy
        render json: :no_content
      else
        json = { errors: @kingdom.errors.full_messages.join(", ") }
        render json: json, status: :unprocessable_entity
      end
    end

    private
      def set_kingdom
        @kingdom = Kingdom.find params[:id]
      end

      def check_can_be_edited_by
        unless @kingdom.can_be_edited_by? current_user
          render json: :forbidden
          return
        end
      end

      def kingdom_params
        params.permit :name, :card_ids, :description, :name
      end
  end
end
