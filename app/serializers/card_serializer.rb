class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :card_type_id, :expansion_id, :cost,
    :cost_in_coins, :text, :card_attributes

  def card_attributes
    object.card_attributes.pluck :name
  end
end
