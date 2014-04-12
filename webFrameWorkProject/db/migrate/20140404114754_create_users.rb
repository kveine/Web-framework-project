class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :firstname
        t.string :surname
        t.string :email
        t.string :salt
        t.string :encrypted_password
		t.timestamps
    end
  end
end
