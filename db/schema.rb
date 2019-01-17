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

ActiveRecord::Schema.define(version: 2018_10_30_170848) do

  create_table "form_changes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "species_id"
    t.integer "number", null: false
    t.string "name", null: false
    t.boolean "is_mega_evolution", null: false
    t.string "form"
    t.string "type1"
    t.string "type2"
    t.string "ability1"
    t.string "ability2"
    t.string "ability3"
    t.integer "hit_point", null: false
    t.integer "attack", null: false
    t.integer "defense", null: false
    t.integer "special_attack", null: false
    t.integer "special_defense", null: false
    t.integer "speed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species_id"], name: "index_form_changes_on_species_id"
  end

  create_table "monsters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "species_group_id"
    t.string "nickname"
    t.string "gender"
    t.integer "level"
    t.string "ability"
    t.string "nature"
    t.string "characteristic"
    t.string "move1"
    t.string "move2"
    t.string "move3"
    t.string "move4"
    t.string "held_item"
    t.string "combat_rules"
    t.string "ball"
    t.boolean "is_colored"
    t.integer "hp_statistics"
    t.integer "attack_statistics"
    t.integer "defense_statistics"
    t.integer "sp_attack_statistics"
    t.integer "sp_defense_statistics"
    t.integer "speed_statistics"
    t.integer "hp_individual"
    t.integer "attack_individual"
    t.integer "defense_individual"
    t.integer "sp_attack_individual"
    t.integer "sp_defense_individual"
    t.integer "speed_individual"
    t.integer "hp_effort"
    t.integer "attack_effort"
    t.integer "defense_effort"
    t.integer "sp_attack_effort"
    t.integer "sp_defense_effort"
    t.integer "speed_effort"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species_group_id"], name: "index_monsters_on_species_group_id"
  end

  create_table "species", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number", null: false
    t.string "name", null: false
    t.boolean "is_form_change", null: false
    t.string "form"
    t.string "type1"
    t.string "type2"
    t.string "ability1"
    t.string "ability2"
    t.string "ability3"
    t.integer "hit_point", null: false
    t.integer "attack", null: false
    t.integer "defense", null: false
    t.integer "special_attack", null: false
    t.integer "special_defense", null: false
    t.integer "speed", null: false
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

  create_table "untrained_monsters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "species_group_id"
    t.string "nickname"
    t.string "gender"
    t.integer "level"
    t.string "ability"
    t.string "nature"
    t.string "characteristic"
    t.string "move1"
    t.string "move2"
    t.string "move3"
    t.string "move4"
    t.string "held_item"
    t.string "combat_rules"
    t.string "ball"
    t.boolean "is_colored"
    t.integer "hp_statistics"
    t.integer "attack_statistics"
    t.integer "defense_statistics"
    t.integer "sp_attack_statistics"
    t.integer "sp_defense_statistics"
    t.integer "speed_statistics"
    t.integer "hp_individual"
    t.integer "attack_individual"
    t.integer "defense_individual"
    t.integer "sp_attack_individual"
    t.integer "sp_defense_individual"
    t.integer "speed_individual"
    t.integer "hp_effort"
    t.integer "attack_effort"
    t.integer "defense_effort"
    t.integer "sp_attack_effort"
    t.integer "sp_defense_effort"
    t.integer "speed_effort"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species_group_id"], name: "index_untrained_monsters_on_species_group_id"
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

  add_foreign_key "form_changes", "species"
  add_foreign_key "monsters", "species_groups"
  add_foreign_key "species_groups", "users"
  add_foreign_key "untrained_monsters", "species_groups"
end
