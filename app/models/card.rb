class Card < ApplicationRecord
  include ByNameOrId

  belongs_to :expansion
  belongs_to :card_type

  has_many :kingdom_cards
  has_many :kingdoms, through: :kingdom_cards
  has_many :card_attribute_links
  has_many :card_attributes, through: :card_attribute_links

  validates :name, presence: true, uniqueness: true
  validates :expansion_id, presence: true

  scope :randomizers, -> { where(randomizable: true) }
  scope :non_randomizers, -> { where(randomizable: false) }

  def image
    base_filename = self.name.gsub(" ", "_").gsub("'", "")
    "#{base_filename}.jpg"
  end
end
