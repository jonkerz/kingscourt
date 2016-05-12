class Kingdom < ApplicationRecord
  has_many :kingdom_cards
  has_many :cards, through: :kingdom_cards

  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true

  def favorite_count
    FavoriteKingdom.where(kingdom: self).count
  end

  def favorited_by? user
    !!FavoriteKingdom.find_by(kingdom: self, user: user)
  end

  def slug
    self.name.slugify
  end
end
