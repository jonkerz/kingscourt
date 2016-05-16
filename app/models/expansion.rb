class Expansion < ApplicationRecord
  include ByNameOrId

  has_many :cards

  validates :name, presence: true, uniqueness: true

  def self.all_card_attributes
    Expansion.find_each.collect do |expansion|
      [expansion.id, expansion.card_attributes]
    end.to_h
  end

  def card_attributes
    cards.collect do |card|
      card.card_attributes.collect(&:name)
    end.flatten.uniq
  end
end
