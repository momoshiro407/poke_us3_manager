class BaseStatusType < ApplicationRecord
  belongs_to :base_status, optional: true
  belongs_to :type, optional: true
end
