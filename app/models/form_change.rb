class FormChange < ApplicationRecord
  belongs_to :species, optional: true
end
