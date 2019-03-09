class ItemNameGroup < ApplicationRecord
  has_one :item
  belongs_to :item_group
end
