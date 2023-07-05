class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :first_name, limit: 100, null: false
      t.string :last_name, limit: 100
      t.string :email, limit: 100, null: false
      t.string :phone_number, limit: 25

      t.timestamps
    end

    add_index :guests, :first_name
    add_index :guests, :last_name
    add_index :guests, :email
    add_index :guests, :email, unique: true, name: 'index_guests_on_email_unique'
  end
end
