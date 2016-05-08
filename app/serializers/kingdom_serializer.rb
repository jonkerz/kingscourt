# TODO
class KingdomSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :cards,
    :kingdom_description, :slug, :username, :description,
    :expansions, :favorites_count

  private
    def cards
      object.cards.pluck :id
    end

    def slug
      "fake-slug"
    end

    def username
      object.user.name
    end

    def kingdom_description
      object.description
    end

    def expansions
      [2, 4, 1, 5]
    end

    def favorites_count
      5
    end
end
