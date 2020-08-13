# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_12_215718) do

  create_table "card_attribute_links", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "card_id"
    t.integer "card_attribute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_attribute_id", "card_id"], name: "index_card_attribute_links_on_card_attribute_id_and_card_id", unique: true
    t.index ["card_attribute_id"], name: "index_card_attribute_links_on_card_attribute_id"
    t.index ["card_id"], name: "index_card_attribute_links_on_card_id"
  end

  create_table "card_attributes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "randomizable"
    t.text "text"
    t.integer "expansion_id"
    t.integer "card_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_in_coins"
    t.string "cost_in_text"
    t.index ["card_type_id"], name: "cards_card_type_id_fk"
    t.index ["expansion_id"], name: "cards_expansion_id_fk"
  end

  create_table "expansions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_kingdoms", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "kingdom_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kingdom_id"], name: "index_favorite_kingdoms_on_kingdom_id"
    t.index ["user_id"], name: "index_favorite_kingdoms_on_user_id"
  end

  create_table "kingdom_cards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "kingdom_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_kingdom_cards_on_card_id"
    t.index ["kingdom_id", "card_id"], name: "index_kingdom_cards_on_kingdom_id_and_card_id", unique: true
    t.index ["kingdom_id"], name: "index_kingdom_cards_on_kingdom_id"
  end

  create_table "kingdoms", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "kingdoms_user_id_fk"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "username"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "admin", default: false
    t.boolean "allow_password_change", default: false, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", length: { item_type: 191 }
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
