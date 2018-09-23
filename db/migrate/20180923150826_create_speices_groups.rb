class CreateSpeicesGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :speices_groups do |t|
      t.references :user, foreign_key: true
      t.integer :speices_number, null: false
      t.string :speices_name, null: false
      t.timestamps
    end
  end
end
