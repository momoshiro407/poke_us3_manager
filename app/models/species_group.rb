class SpeciesGroup < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :species_number, :species_name, presence: true

end
