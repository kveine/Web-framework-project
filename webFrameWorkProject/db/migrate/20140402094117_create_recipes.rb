class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
		t.string :title
		t.integer :catogory_id
		t.string :ingredients
		t.string :instructions
		t.integer :feed_id
		t.timestamps
    end
  end
end
