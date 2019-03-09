class RemoveSpeciesNumberAndNameToSpeciesGroup < ActiveRecord::Migration[5.2]
  def change
    remove_column :species_groups, :species_number, :integer
    remove_column :species_groups, :species_name, :string
  end
end
