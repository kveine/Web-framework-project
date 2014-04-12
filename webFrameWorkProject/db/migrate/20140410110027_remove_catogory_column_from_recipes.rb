class RemoveCatogoryColumnFromRecipes < ActiveRecord::Migration
  def change
  	remove_column :recipes, :catogory
  end
end
