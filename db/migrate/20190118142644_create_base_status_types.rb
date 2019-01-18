class CreateBaseStatusTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :base_status_types do |t|
      t.references :base_status, foreign_key: true
      t.references :types, foreign_key: true
    end
  end
end
