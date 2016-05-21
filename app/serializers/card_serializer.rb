class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :card_type_id, :expansion_id, :cost_in_text,
    :cost_in_coins, :text, :card_attributes, :image

  def card_attributes
    object.card_attributes.pluck :name
  end
end
