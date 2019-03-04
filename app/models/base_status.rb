class BaseStatus < ApplicationRecord
  belongs_to :species, optional: true
  has_many :base_status_types
  has_many :base_status_abilities
  has_many :types, through: :base_status_types
end
