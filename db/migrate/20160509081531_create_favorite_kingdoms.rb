class CreateFavoriteKingdoms < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_kingdoms do |t|
      t.references :kingdom, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
