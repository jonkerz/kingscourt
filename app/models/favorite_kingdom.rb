class FavoriteKingdom < ApplicationRecord
  belongs_to :kingdom
  belongs_to :user

  validates :kingdom, presence: true
  validates :user, presence: true

  after_destroy :reindex_kingdom
  after_save :reindex_kingdom

  private

    # TODO: delayed_job.
    def reindex_kingdom
      Sunspot.index kingdom
    end
end
