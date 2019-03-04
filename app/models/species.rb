class Species < ApplicationRecord
  has_many :species_groups
  has_many :base_statuses
  has_many :monsters, through: :species_groups
  has_many :untrained_monsters, through: :species_groups
end
