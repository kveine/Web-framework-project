class ChangeCategoryColumnRecipes < ActiveRecord::Migration
  def change
  		remove_column :users, :category
  		add_column :users, :category_id, :integer
  end
end
