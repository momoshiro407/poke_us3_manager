class CreateItemNameGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :item_name_groups do |t|
      t.references :item, foreign_key: true
      t.references :item_group, foreign_key: true
    end
  end
end
