class BaseStatusAbility < ApplicationRecord
  belongs_to :base_status, optional: true
  belongs_to :ability, optional: true
end
