module Api::V1
  class KingdomsController < ApiController
    include CleanPagination
    before_action :set_kingdom, only: [:show, :update, :destroy]
    before_action :check_can_be_edited_by, only: [:update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
      @kingdoms = build_results
      filter_by_expansion

      max_per_page = 100
      paginate @kingdoms.count, max_per_page do |limit, offset|
        render json: @kingdoms.limit(limit).offset(offset)
      end
    end

    def show
      render json: @kingdom
    end

    def create
      kingdom = Kingdom.new kingdom_params
      kingdom.user = current_user
      kingdom.card_ids = params[:card_ids]

      if kingdom.save
        render json: kingdom
      else
        json = { errors: kingdom.errors.full_messages.join(", ") }
        render json: json, status: :unprocessable_entity
      end
    end

    def update
      @kingdom.card_ids = params[:card_ids]
      if @kingdom.update kingdom_params
        render json: @kingdom
      else
        json = { errors: @kingdom.errors.full_messages.join(", ") }
        render json: json, status: :unprocessable_entity
      end
    end

    def destroy
      if @kingdom.destroy
        render json: {}, status: :ok
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
          render json: {}, status: :unauthorized
          return
        end
      end

      def build_results
        if params[:my_kingdoms]
          Kingdom.where(user: current_user)
        elsif params[:favoriter]
          User.find_by(username: params[:favoriter]).favorites
        elsif params[:my_favorites]
          current_user.favorites
        elsif params[:username]
          user = User.find_by(username: params[:username])
          Kingdom.where(user: user)
        else
          Kingdom.all
        end
      end

      def filter_by_expansion
        return unless params[:expansions].present?

        expansions = params[:expansions].split(",")
        @kingdoms = @kingdoms.joins(:cards)
          .where(cards: { expansion_id: expansions }).distinct
      end

      def kingdom_params
        params.permit :name, :card_ids, :description, :name
      end
  end
end
