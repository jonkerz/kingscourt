class Expansion < ApplicationRecord
  validates :name, presence: true
  has_many :cards

  def self.all_card_attributes
    Expansion.all.each.collect do |expansion|
      [ expansion.id, expansion.card_attributes ]
    end.to_h
  end

  def card_attributes
    cards.collect do |card|
      card.card_attributes.collect { |attribute| attribute.name }
    end.flatten.uniq
  end
end
