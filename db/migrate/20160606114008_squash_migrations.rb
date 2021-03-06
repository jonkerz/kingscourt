class SquashMigrations < ActiveRecord::Migration[5.0]
  def up
    create_table "card_attribute_links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer  "card_id"
      t.integer  "card_attribute_id"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.index ["card_attribute_id", "card_id"], name: "index_card_attribute_links_on_card_attribute_id_and_card_id", unique: true, using: :btree
      t.index ["card_attribute_id"], name: "index_card_attribute_links_on_card_attribute_id", using: :btree
      t.index ["card_id"], name: "index_card_attribute_links_on_card_id", using: :btree
    end

    create_table "card_attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "card_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "name"
      t.boolean  "randomizable"
      t.text     "text",          limit: 65535
      t.integer  "expansion_id"
      t.integer  "card_type_id"
      t.datetime "created_at",                  null: false
      t.datetime "updated_at",                  null: false
      t.integer  "cost_in_coins"
      t.string   "cost_in_text"
      t.index ["card_type_id"], name: "cards_card_type_id_fk", using: :btree
      t.index ["expansion_id"], name: "cards_expansion_id_fk", using: :btree
    end

    create_table "expansions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "favorite_kingdoms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer  "kingdom_id"
      t.integer  "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["kingdom_id"], name: "index_favorite_kingdoms_on_kingdom_id", using: :btree
      t.index ["user_id"], name: "index_favorite_kingdoms_on_user_id", using: :btree
    end

    create_table "kingdom_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer  "kingdom_id"
      t.integer  "card_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["card_id"], name: "index_kingdom_cards_on_card_id", using: :btree
      t.index ["kingdom_id", "card_id"], name: "index_kingdom_cards_on_kingdom_id_and_card_id", unique: true, using: :btree
      t.index ["kingdom_id"], name: "index_kingdom_cards_on_kingdom_id", using: :btree
    end

    create_table "kingdoms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "name"
      t.text     "description", limit: 65535
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
      t.integer  "user_id"
      t.index ["user_id"], name: "kingdoms_user_id_fk", using: :btree
    end

    create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "provider",                             default: "email", null: false
      t.string   "uid",                                  default: "",      null: false
      t.string   "encrypted_password",                   default: "",      null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",                        default: 0,       null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.string   "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string   "unconfirmed_email"
      t.string   "username"
      t.string   "email"
      t.text     "tokens",                 limit: 65535
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "admin",                                default: false
      t.index ["email"], name: "index_users_on_email", using: :btree
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
      t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
    end

    create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
      t.string   "item_type",                     null: false
      t.integer  "item_id",                       null: false
      t.string   "event",                         null: false
      t.string   "whodunnit"
      t.text     "object",     limit: 4294967295
      t.datetime "created_at"
      t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", length: {"item_type"=>191, "item_id"=>nil}, using: :btree
    end

    add_foreign_key "card_attribute_links", "card_attributes"
    add_foreign_key "card_attribute_links", "cards"
    add_foreign_key "cards", "card_types", name: "cards_card_type_id_fk"
    add_foreign_key "cards", "expansions", name: "cards_expansion_id_fk"
    add_foreign_key "favorite_kingdoms", "kingdoms", name: "favorite_kingdoms_kingdom_id_fk"
    add_foreign_key "favorite_kingdoms", "users", name: "favorite_kingdoms_user_id_fk"
    add_foreign_key "kingdom_cards", "cards", name: "kingdom_cards_card_id_fk"
    add_foreign_key "kingdom_cards", "kingdoms", name: "kingdom_cards_kingdom_id_fk"
    add_foreign_key "kingdoms", "users", name: "kingdoms_user_id_fk"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
