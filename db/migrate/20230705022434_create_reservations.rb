class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code, limit: 100, null: false
      t.references :guest, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :night_count, null: false
      t.integer :guest_count, null: false
      t.integer :adult_count, null: false
      t.integer :children_count
      t.integer :infant_count
      t.string :currency, limit: 100, null: false
      t.decimal :sub_total_price, precision: 10, scale: 2, null: false
      t.decimal :additional_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.string :status, limit: 100, null: false

      t.timestamps
    end

    add_index :reservations, :code
    add_index :reservations, :code, unique: true, name: "index_reservations_on_code_unique"
    add_index :reservations, :start_date
    add_index :reservations, :end_date
  end
end
