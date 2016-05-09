class FavoriteKingdom < ApplicationRecord
  belongs_to :kingdom
  belongs_to :user

  validates :kingdom, presence: true
  validates :user, presence: true
end
