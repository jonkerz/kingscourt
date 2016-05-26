class Kingdom < ApplicationRecord
  has_many :kingdom_cards
  has_many :cards, through: :kingdom_cards, dependent: :destroy

  has_many :favorite_kingdoms
  has_many :favorites, through: :favorite_kingdoms,
    source: :kingdom, dependent: :destroy

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
      errors.add :cards, "must contain 10 cards" unless cards.size == 10
      unless cards.all?(&:randomizable?)
        errors.add :cards, <<-MSG.squish
          can only contain randomizable cards (remove
          #{cards.non_randomizers.pluck(:name).to_sentence})
        MSG
      end
    end
end
