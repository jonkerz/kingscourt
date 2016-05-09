class CreateNewCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.boolean :randomizable
      t.text :text
      t.integer :expansion_id
      t.integer :card_type_id

      t.timestamps
    end
  end
end
