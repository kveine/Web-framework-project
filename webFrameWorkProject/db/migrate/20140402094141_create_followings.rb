class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
		t.integer :user_id
		t.integer :feed_id
      	t.timestamps
    end
  end
end
