class CreateUntrainedMonsters < ActiveRecord::Migration[5.2]
  def change
    create_table :untrained_monsters do |t|
      t.references :species_group, foreign_key: true
      t.string :nickname
      t.integer :gender
      t.integer :level
      t.integer :ability_id
      t.integer :nature_id
      t.integer :characteristic_id
      t.string :move1
      t.string :move2
      t.string :move3
      t.string :move4
      t.integer :held_item_id
      t.integer :combat_rule
      t.string :ball
      t.boolean :is_colored
      t.integer :hp_statistics
      t.integer :attack_statistics
      t.integer :defense_statistics
      t.integer :sp_attack_statistics
      t.integer :sp_defense_statistics
      t.integer :speed_statistics
      t.integer :hp_individual
      t.integer :attack_individual
      t.integer :defense_individual
      t.integer :sp_attack_individual
      t.integer :sp_defense_individual
      t.integer :speed_individual
      t.integer :hp_effort
      t.integer :attack_effort
      t.integer :defense_effort
      t.integer :sp_attack_effort
      t.integer :sp_defense_effort
      t.integer :speed_effort
      t.text :memo
      t.timestamps
    end
  end
end
