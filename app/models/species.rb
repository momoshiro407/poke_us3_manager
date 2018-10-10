class Species < ApplicationRecord
  has_many :species_groups
  has_one :base_stats_unit
end
