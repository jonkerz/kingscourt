class Card < ApplicationRecord
  has_many :kingdom_cards
  has_many :kingdoms, through: :kingdom_cards
end
