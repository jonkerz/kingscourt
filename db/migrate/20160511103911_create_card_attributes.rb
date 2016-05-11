class CreateCardAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :card_attributes do |t|
      t.string :name

      t.timestamps
    end
  end
end
