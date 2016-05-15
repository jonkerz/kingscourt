class CardType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
