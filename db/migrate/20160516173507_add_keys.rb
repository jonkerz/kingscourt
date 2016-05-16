class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "cards", "card_types", name: "cards_card_type_id_fk"
    add_foreign_key "cards", "expansions", name: "cards_expansion_id_fk"
    add_foreign_key "favorite_kingdoms", "kingdoms", name: "favorite_kingdoms_kingdom_id_fk"
    add_foreign_key "favorite_kingdoms", "users", name: "favorite_kingdoms_user_id_fk"
    add_foreign_key "kingdom_cards", "cards", name: "kingdom_cards_card_id_fk"
    add_foreign_key "kingdom_cards", "kingdoms", name: "kingdom_cards_kingdom_id_fk"
    add_foreign_key "kingdoms", "users", name: "kingdoms_user_id_fk"
  end
end
