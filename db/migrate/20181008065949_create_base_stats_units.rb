class CreateBaseStatsUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :base_stats_units do |t|
      t.references :species, foreign_key: true
      t.integer :form
      t.integer :hit_point
      t.integer :attack
      t.integer :defense
      t.integer :special_attack
      t.integer :special_defense
      t.integer :speed
      t.timestamps
    end
  end
end
