class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.boolean :randomizable
      t.text :text
      t.string :expansion
      t.string :card_type

      t.timestamps
    end
  end
end
