class AddFeedIdToUser < ActiveRecord::Migration
  def change
  	add_column :users, :feed_id, :integer
  end
end
