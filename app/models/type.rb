class Type < ApplicationRecord
  has_many :base_status_types
  has_many :base_statuses, through: :base_status_types
end
