class Expansion < ApplicationRecord
  include ByNameOrId

  has_many :cards

  validates :name, presence: true, uniqueness: true

  def self.all_card_attributes
    Expansion.includes(cards: :card_attributes).find_each.map do |expansion|
      [expansion.id, expansion.card_attributes]
    end.to_h
  end

  def card_attributes
    cards.map do |card|
      card.card_attributes.map(&:name)
    end.flatten.uniq
  end
end
