class RemoveColumnEncyptedPasswordFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :encypted_password
  	add_column :users, :encrypted_password, :string
  end
end
