class Monster < ApplicationRecord
  belongs_to :species_group
  has_one :species, through: :species_group

  scope :with_species_group, -> (species_group_id) { joins(:species_group).merge(SpeciesGroup.where(id: species_group_id)) }
  scope :search_nickname, -> (nickname) { where("nickname like ?", "%#{nickname}%") }
  scope :search_gender, -> (gender) { where(gender: gender) }
  scope :search_ability, -> (ability) { where(ability_id: ability) }
  scope :search_nature, -> (nature) { where(nature_id: nature) }
  scope :search_move, -> (move) { where("move1 = ? OR move2 = ? OR move3 = ? OR move4 = ?", move, move, move, move) }

end
