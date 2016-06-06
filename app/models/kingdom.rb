class Kingdom < ApplicationRecord
  belongs_to :user

  has_many :kingdom_cards
  has_many :cards, through: :kingdom_cards, dependent: :destroy

  has_many :favorite_kingdoms
  has_many :favoriters, through: :favorite_kingdoms,
    source: :user, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true, length: 5..50
  validate :validate_cards

  searchable do
    integer :expansion_ids, multiple: true do expansions end
    string :expansion_ids_string do expansions.to_s end
    integer :user_id
    integer :favorited_by_user_ids, multiple: true do
      favoriters.map(&:id)
    end
  end

  def expansions
    cards.map(&:expansion_id).uniq.sort
  end

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

  # Slow and naive method used only when importing.
  def find_duplicates!
    Kingdom.find_each do |kingdom|
      if kingdom.card_ids.sort == card_ids.sort
        errors.add :base, "'#{name}' looks like a duplicate '#{kingdom.name}'"
      end
    end
  end

  private

    def validate_cards
      errors.add :cards, "must contain 10 cards" unless cards.size == 10
      unless cards.all?(&:randomizable?)
        errors.add :cards, <<-MSG.squish
          can only contain randomizable cards (remove
          #{cards.non_randomizable.pluck(:name).to_sentence})
        MSG
      end
    end
end
