class CreateFormChange < ActiveRecord::Migration[5.2]
  def change
    create_table :form_changes do |t|
      t.references :species, foreign_key: true
      t.integer :number, null: false
      t.string :name, null: false
      t.string :type1
      t.string :type2
      t.string :ability1
      t.string :ability2
      t.string :ability3
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
