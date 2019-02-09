class AddBaseStatusIdToUntrainedMonsters < ActiveRecord::Migration[5.2]
  def change
    add_column :untrained_monsters, :base_status_id, :integer
  end
end
