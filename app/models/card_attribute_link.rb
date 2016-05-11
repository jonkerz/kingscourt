class CardAttributeLink < ApplicationRecord
  belongs_to :card
  belongs_to :card_attribute
end
