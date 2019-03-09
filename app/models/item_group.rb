class ItemGroup < ApplicationRecord
  has_many :item_name_groups
  has_many :items, through: :item_name_groups
end
