# TODO: Improve.

class FilterKingdoms
  PER_PAGE = 5

  def initialize params, current_user:
    @params = params
    @current_user = current_user
  end

  def call
    filter_kingdoms
  end

  private

    attr_reader :params, :current_user

    def filter_kingdoms # rubocop:disable Metrics/MethodLength
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

        order_by :created_at, :desc

        # Facets
        facet :expansion_ids
        facet :expansion_ids_string

        # Paginate
        paginate page: (params[:page] || 1), per_page: PER_PAGE
      end
    end
end
