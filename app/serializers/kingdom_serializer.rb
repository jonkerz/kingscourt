# TODO
class KingdomSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :cards,
    :kingdom_description, :slug, :username, :description,
    :expansions, :favorite_count, :favorite

  private
    def cards
      object.cards.pluck :id
    end

    def slug
      "fake-slug"
    end

    def username
      object.user.username
    end

    def kingdom_description
      object.description
    end

    def expansions
      [2, 4, 1, 5]
    end

    def favorite
      return unless scope.current_user
      object.favorited_by? scope.current_user
    end
end
