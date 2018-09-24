class RenameSpeicesColumnsSpecies < ActiveRecord::Migration[5.2]
  def change
    rename_column :species_groups, :speices_number, :species_number
    rename_column :species_groups, :speices_name, :species_name
  end
end
