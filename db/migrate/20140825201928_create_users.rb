class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :phone_number, :limit => 8
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :password_digest
      t.string :type

      t.timestamps
    end
  end
end
