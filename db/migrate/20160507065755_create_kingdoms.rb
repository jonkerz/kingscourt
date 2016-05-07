class CreateKingdoms < ActiveRecord::Migration[5.0]
  def change
    create_table :kingdoms do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
