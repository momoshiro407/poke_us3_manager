class RenameSpeicesGroupToSpeciesGroup < ActiveRecord::Migration[5.2]
  def change
    rename_table :speices_groups, :species_groups
  end
end
