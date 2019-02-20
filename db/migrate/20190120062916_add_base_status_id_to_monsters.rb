class AddBaseStatusIdToMonsters < ActiveRecord::Migration[5.2]
  def change
    add_column :monsters, :base_status_id, :integer
  end
end
