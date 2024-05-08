class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: false
      t.integer :shop_id, null: false
      t.date :date, null: false
      t.string :time, null: false
      t.integer :member, null: false
      t.boolean :status, null: false, default: true
      t.timestamps
    end
  end
end
