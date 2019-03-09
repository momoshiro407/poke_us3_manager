class ItemNameGroup < ApplicationRecord
  belongs_to :item
  belongs_to :item_group
end
