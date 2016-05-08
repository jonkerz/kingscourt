class Kingdom < ApplicationRecord
  has_many :kingdom_cards
  has_many :cards, through: :kingdom_cards

  belongs_to :user

  validates :user, presence: true
end
