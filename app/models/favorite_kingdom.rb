class FavoriteKingdom < ApplicationRecord
  belongs_to :kingdom
  belongs_to :user

  validates :kingdom, presence: true
  validates :user, presence: true

  after_save :reindex_kingdom
  after_destroy :reindex_kingdom

  # TODO: delayed_job
  private
    def reindex_kingdom
      Sunspot.index kingdom
    end
end
