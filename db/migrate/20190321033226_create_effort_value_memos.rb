class CreateEffortValueMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :effort_value_memos do |t|
      t.references :untrained_monster, foreign_key: true
      t.integer :hp_effort_value, null: true
      t.integer :attack_effort_value, null: true
      t.integer :defense_effort_value, null: true
      t.integer :sp_attack_effort_value, null: true
      t.integer :sp_defense_effort_value, null: true
      t.integer :speed_effort_value, null: true
      t.timestamps
    end
  end
end
