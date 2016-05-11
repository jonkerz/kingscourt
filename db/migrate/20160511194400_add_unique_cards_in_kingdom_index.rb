class AddUniqueCardsInKingdomIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :kingdom_cards, [:kingdom_id, :card_id], unique: true
  end
end
