class Kingdom < ApplicationRecord
  has_many :kingdom_cards
  has_many :cards, through: :kingdom_cards

  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
  validate :validate_cards

  def favorite_count
    FavoriteKingdom.where(kingdom: self).count
  end

  def favorited_by? user
    !!FavoriteKingdom.find_by(kingdom: self, user: user)
  end

  def slug
    self.name.slugify
  end

  def can_be_edited_by? user
    self.user == user
  end

  private
    def validate_cards
      unless cards.size == 10
        errors.add :cards, "must contain 10 cards"
      end
      unless cards.all?(&:randomizable?)
        errors.add :cards, <<-MSG.squish
          can only contain randomizable cards (remove
          #{cards.non_randomizers.pluck(:name).to_sentence})
        MSG
      end
    end
end
