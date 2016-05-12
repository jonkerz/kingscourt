class KingdomSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :cards,
    :description, :slug, :username, :description,
    :expansions, :favorite_count, :favorite

  def cards
    object.cards.pluck :id
  end

  def username
    object.user.username
  end

  def expansions
    [2, 4, 1, 5]
  end

  def favorite
    return unless scope.current_user
    object.favorited_by? scope.current_user
  end
end
