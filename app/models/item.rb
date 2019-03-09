class Item < ApplicationRecord
  has_many :item_name_groups
  has_one :item_group, through: :item_name_group
end
