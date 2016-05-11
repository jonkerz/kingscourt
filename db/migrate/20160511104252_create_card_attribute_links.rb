class CreateCardAttributeLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :card_attribute_links do |t|
      t.belongs_to :card, foreign_key: true
      t.belongs_to :card_attribute, foreign_key: true

      t.timestamps
    end
  end
end
