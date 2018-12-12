class RenameSeedColumnsToUntrainedMonsters < ActiveRecord::Migration[5.2]
  def change
    rename_column :untrained_monsters, :seed_statistics, :speed_statistics
    rename_column :untrained_monsters, :seed_individual, :speed_individual
    rename_column :untrained_monsters, :seed_effort, :speed_effort
  end
end
