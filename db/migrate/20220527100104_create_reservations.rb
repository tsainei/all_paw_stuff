class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :total_price
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true
      t.references :accessory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
