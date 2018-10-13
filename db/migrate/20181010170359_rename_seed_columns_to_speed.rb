class RenameSeedColumnsToSpeed < ActiveRecord::Migration[5.2]
  def change
    rename_column :monsters, :seed_statistics, :speed_statistics
    rename_column :monsters, :seed_individual, :speed_individual
    rename_column :monsters, :seed_effort, :speed_effort
  end
end
