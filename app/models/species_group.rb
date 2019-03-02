class SpeciesGroup < ApplicationRecord
  belongs_to :user
  belongs_to :species, optional: true
  has_many :monsters
  has_many :untrained_monsters

  validates :user_id, presence: true
  validates :species_id, presence: true
end
