class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.integer :gender, default: 0, limit: 1
      t.integer :combat_rule, default: 0, limit: 1

      t.timestamps
    end
  end
end
