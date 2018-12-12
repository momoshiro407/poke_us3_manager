class UntrainedMonster < ApplicationRecord
  belongs_to :species_group

  scope :with_species_group, -> (species_group_id) { joins(:species_group).merge(SpeciesGroup.where(id: species_group_id)) }

end
