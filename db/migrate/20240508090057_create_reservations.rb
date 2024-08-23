class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: false
      t.integer :restrant_id, null: false
      t.string :name, null: false
      t.integer :member, null: false
      t.boolean :status, null: false, default: true
      t.timestamps
    end
  end
end
