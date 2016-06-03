class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :card_type_id, :expansion_id, :cost_in_text,
    :cost_in_coins, :text, :image

  has_many :card_attributes, serializer: CardAttributeSerializer
end
