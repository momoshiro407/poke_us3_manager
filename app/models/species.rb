class Species < ApplicationRecord
  has_many :species_groups
  has_many :base_statuses
end
