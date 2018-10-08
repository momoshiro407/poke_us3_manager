class RenameSpeciesNumberAndNameToSpecies < ActiveRecord::Migration[5.2]
  def change
    rename_column :species, :species_number, :number
    rename_column :species, :species_name, :name
  end
end
