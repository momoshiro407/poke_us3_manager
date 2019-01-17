class CreateSpeciesGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :species_groups do |t|
      t.references :user, foreign_key: true
      t.integer :species_number, null: false
      t.string :species_name, null: false
      t.timestamps
    end
  end
end
