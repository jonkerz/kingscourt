class AddUniqueCardAttributesPerCard < ActiveRecord::Migration[5.0]
  def change
    add_index :card_attribute_links, [:card_attribute_id, :card_id], unique: true
  end
end
