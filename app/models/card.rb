class Card < ApplicationRecord
  belongs_to :expansion
  has_many :kingdom_cards
  has_many :kingdoms, through: :kingdom_cards
  has_many :card_attribute_links
  has_many :card_attributes, through: :card_attribute_links
end
