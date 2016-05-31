module Api::V1
  class KingdomsController < ApiController
    before_action :set_kingdom, only: [:show, :update, :destroy]
    before_action :check_can_be_edited_by, only: [:update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
      kingdoms = filter_kingdoms

      expansion_facets = {}
      kingdoms.facet(:expansion_ids).rows.each do |row|
        expansion_facets[row.value] = row.count
      end

      render json: kingdoms.results,
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

      def filter_kingdoms
        Sunspot.search(Kingdom) do
          # Filter by kingdom creator, favorites
          if params[:my_kingdoms]
            with :user_id, current_user.id
          elsif params[:username]
            user = User.find_by(username: params[:username])
            with :user_id, user.id
          elsif params[:favoriter]
            user = User.find_by(username: params[:favoriter])
            with :favorited_by_user_ids, user.id
          elsif params[:my_favorites]
            with :favorited_by_user_ids, current_user.id
          end

          # Filter by expansions
          if params[:expansions].present?
            expansions = params[:expansions].split(",").map(&:to_i)
            if params[:match_all_expansions] == "true"
              with :expansion_ids_string, expansions.sort.to_s
            else
              without_expansion = (Set.new(1..11) ^ expansions).to_a
              without :expansion_ids, without_expansion
            end
          end

          # Facets
          facet :expansion_ids
          facet :expansion_ids_string

          # Paginate
          paginate page: (params[:page] || 1), per_page: 5
        end
      end

      def kingdom_params
        params.permit :name, :card_ids, :description, :name
      end
  end
end
