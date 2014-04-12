class RemoveFeedIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :feed_id
  end
end
