class Species < ApplicationRecord
  has_many :species_groups
  has_many :form_changes
end
