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

ActiveRecord::Schema.define(version: 2019_01_20_062929) do

  create_table "abilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ability_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "base_status_abilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "base_status_id"
    t.bigint "ability_id"
    t.index ["ability_id"], name: "index_base_status_abilities_on_ability_id"
    t.index ["base_status_id"], name: "index_base_status_abilities_on_base_status_id"
  end

  create_table "base_status_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "base_status_id"
    t.bigint "type_id"
    t.index ["base_status_id"], name: "index_base_status_types_on_base_status_id"
    t.index ["type_id"], name: "index_base_status_types_on_type_id"
  end

  create_table "base_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "species_id"
    t.integer "form_kind", null: false
    t.string "form_name"
    t.integer "hit_point", null: false
    t.integer "attack", null: false
    t.integer "defense", null: false
    t.integer "special_attack", null: false
    t.integer "special_defense", null: false
    t.integer "speed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species_id"], name: "index_base_statuses_on_species_id"
  end

  create_table "monsters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "species_group_id"
    t.string "nickname"
    t.string "gender"
    t.integer "level"
    t.integer "ability_id"
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
    t.integer "base_status_id"
    t.index ["species_group_id"], name: "index_monsters_on_species_group_id"
  end

  create_table "species", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number", null: false
    t.string "name", null: false
    t.boolean "is_mega_evolution", null: false
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

  create_table "types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "untrained_monsters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "species_group_id"
    t.string "nickname"
    t.string "gender"
    t.integer "level"
    t.integer "ability_id"
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
    t.integer "base_status_id"
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

  add_foreign_key "base_status_abilities", "abilities"
  add_foreign_key "base_status_abilities", "base_statuses"
  add_foreign_key "base_status_types", "base_statuses"
  add_foreign_key "base_status_types", "types"
  add_foreign_key "base_statuses", "species"
  add_foreign_key "monsters", "species_groups"
  add_foreign_key "species_groups", "users"
  add_foreign_key "untrained_monsters", "species_groups"
end
