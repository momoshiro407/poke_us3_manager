class CreateItemGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :item_groups do |t|
      t.string :name, null: false
    end
  end
end
