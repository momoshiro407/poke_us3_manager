class SpeciesGroup < ApplicationRecord
  belongs_to :user
  has_many :monsters
  has_many :untrained_monsters

  validates :user_id, presence: true
  validates :species_number, :species_name, presence: true
end
