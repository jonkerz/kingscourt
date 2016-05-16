class CardAttribute < ApplicationRecord
  include ByNameOrId

  has_many :card_attribute_links
  has_many :cards, through: :card_attribute_links

  validates :name, presence: true, uniqueness: true
end
