class CreateBaseStatusAbilities < ActiveRecord::Migration[5.2]
  def change
    create_table :base_status_abilities do |t|
      t.references :base_status, foreign_key: true
      t.references :abilities, foreign_key: true
    end
  end
end
