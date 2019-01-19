class CreateBaseStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :base_statuses do |t|
      t.references :species, foreign_key: true
      t.integer :form_kind, null: false
      t.string :form_name
      t.integer :hit_point, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :special_attack, null: false
      t.integer :special_defense, null: false
      t.integer :speed, null: false
      t.timestamps
    end
  end
end
