class CardType < ApplicationRecord
  include ByNameOrId

  validates :name, presence: true, uniqueness: true
end
