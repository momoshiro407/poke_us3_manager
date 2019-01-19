class CreateAbilities < ActiveRecord::Migration[5.2]
  def change
    create_table :abilities do |t|
      t.string :ability_name, null: false
      t.timestamps
    end
  end
end
