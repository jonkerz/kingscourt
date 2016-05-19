class CardType < ApplicationRecord
  include ByNameOrId

  has_many :cards

  validates :name, presence: true, uniqueness: true
end
