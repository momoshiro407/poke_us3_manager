class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.integer :species_number, null: false
      t.string :species_name, null: false
      t.boolean :is_form_change, null: false
      t.timestamps
    end
  end
end
