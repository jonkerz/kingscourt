class CreateKingdomCards < ActiveRecord::Migration[5.0]
  def change
    create_table :kingdom_cards do |t|
      t.belongs_to :kingdom, foreign_key: true
      t.belongs_to :card, foreign_key: true

      t.timestamps
    end
  end
end
