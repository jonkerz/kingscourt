class Card < ApplicationRecord
  belongs_to :expansion
  belongs_to :card_type

  has_many :kingdom_cards
  has_many :kingdoms, through: :kingdom_cards
  has_many :card_attribute_links
  has_many :card_attributes, through: :card_attribute_links

  validates :name, presence: true
  validates :expansion_id, presence: true

  def image
    base_filename = self.name.gsub(" ", "_").gsub("'", "")
    "/cards/#{base_filename}.jpg"
  end
end
