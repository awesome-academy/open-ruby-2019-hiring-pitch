class CreatePitches < ActiveRecord::Migration[6.0]
  def up
    create_table :pitches do |t|
      t.text :description
      t.string :address
      t.string :image
      t.datetime :start_time
      t.datetime :end_time
      t.float :price
      t.integer :status, default: 1

      t.timestamps
    end
    add_index :pitches, [:user_id, :created_at]
  end

  def down
    remove_index :pitches, [:user_id, :created_at]
  end
end
