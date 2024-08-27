class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: false
      t.integer :restrant_id, null: false
      t.date :date, null: false
      t.string :name, null: false
      t.integer :member, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
