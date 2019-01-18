class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.integer :number, null: false
      t.string :name, null: false
      t.boolean :is_mega_evolution, null: false
      t.boolean :is_form_change, null: false
      t.timestamps
    end
  end
end
