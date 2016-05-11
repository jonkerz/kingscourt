# TODO
class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :expansion, :cost,
    :cost_in_coins, :text, :card_attributes

  def type
    object.card_type_id
  end

  def expansion
    object.expansion_id
  end

  def card_attributes
    object.card_attributes.pluck :name
  end
end
