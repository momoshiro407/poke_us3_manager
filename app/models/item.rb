class Item < ApplicationRecord
  has_one :item_name_group
  has_one :item_group, through: :item_name_group
end
