class CreateNatures < ActiveRecord::Migration[5.2]
  def change
    create_table :natures do |t|
      t.string :name
      t.integer :up_status
      t.integer :down_status

      t.timestamps
    end
  end
end
