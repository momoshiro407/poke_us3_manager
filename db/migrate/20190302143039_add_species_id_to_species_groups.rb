class AddSpeciesIdToSpeciesGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :species_groups, :species, index: true
  end
end
