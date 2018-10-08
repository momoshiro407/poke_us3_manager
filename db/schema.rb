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

ActiveRecord::Schema.define(version: 2018_10_08_151445) do

  create_table "base_stats_units", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "species_id"
    t.integer "form"
    t.integer "hit_point"
    t.integer "attack"
    t.integer "defense"
    t.integer "special_attack"
    t.integer "special_defense"
    t.integer "speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species_id"], name: "index_base_stats_units_on_species_id"
  end

  create_table "species", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number", null: false
    t.string "name", null: false
    t.boolean "is_form_change", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "species_number", null: false
    t.string "species_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_species_groups_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
  end

  add_foreign_key "base_stats_units", "species"
  add_foreign_key "species_groups", "users"
end
