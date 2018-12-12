class RenameAvilityColumnToAbility < ActiveRecord::Migration[5.2]
  def change
    rename_column :monsters, :avility, :ability
  end
end
