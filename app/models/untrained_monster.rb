class UntrainedMonster < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :species_group
  has_one :species, through: :species_group

  scope :with_species_group, -> (species_group_id) { joins(:species_group).merge(SpeciesGroup.where(id: species_group_id)) }
  scope :search_nickname, -> (nickname) { where("nickname like ?", "%#{nickname}%") }
  scope :search_gender, -> (gender) { where(gender: gender) }
  scope :search_ability, -> (ability) { where(ability_id: ability) }
  scope :search_nature, -> (nature) { where(nature_id: nature) }
  scope :search_move, -> (move) { where("move1 = ? OR move2 = ? OR move3 = ? OR move4 = ?", move, move, move, move) }
  # TODO: monsterの検索処理と丸かぶりなので後で1つにまとめる
  validates :hp_effort, :attack_effort , :defense_effort,
            :sp_attack_effort, :sp_defense_effort, :speed_effort,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: Constants::ONE_EFFORT_LIMIT }, allow_blank: true
  validates_with TotalEffortValuesValidator

end
