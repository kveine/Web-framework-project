class RecipesController < ApplicationController
  
  def new
	 @recipe = Recipe.new
  end
 
  def create
    recipe_params = params.require(:recipe).permit(:title, :ingredients, :instructions, :category_id, :avatar)
  	#@recipe = Recipe.new(:title => recipe_params[:title], :ingredients => recipe_params[:ingredients], 
    #                      :instructions => recipe_params[:instructions], :feed_id => @current_user.feed.id, 
    #                      :category_id => recipe_params[:category_id])

    @recipe = Recipe.new(recipe_params)
    @recipe.feed = @current_user.feed
    debugger
  	if @recipe.save!
      @followings = Following.where("feed_id =?", @recipe.feed.id)
      breakpoint
      if @followings.present?
        @to_users = ''
        @followings.each do |a|
          @to_users << a.user.email
          @to_users << ','
        end
        @from_user = @recipe.feed.user.firstname
        @title = @recipe.title
        @ingredients = @recipe.ingredients
        @instructions = @recipe.instructions
        FollowingMailer.new_recipe_email(@to_users, @from_user, @title, @ingredients, @instructions).deliver
      end
      redirect_to user_path(:id => @current_user.id)
    else
      flash[:notice] = "Recipe not saved"
      render 'new'
    end
  end

  def delete
    delete_params = params.require(:recipe).permit(:recipe_id)
    @delete = Recipe.where("id = ?", delete_params[:recipe_id]).take 
    @delete.destroy
    @delete.save

    @delete_favourite = Favourite.where("recipe_id = ?", delete_params[:recipe_id])
    @delete_favourite.each do |t|
      t.destroy
      t.save
    end

    redirect_to user_path(:id => @current_user.id)
  end

  def search
    @page_header = "Latest recipes"
    @recipes = Recipe.all.reverse
    @users = nil
  end
  
  def results
     search_params = params[:search]
     @page_header = "Search results for: #{search_params}" 
     @recipes = Recipe.find_by_sql("SELECT * FROM recipes WHERE title LIKE '%#{params[:search]}%'")
     @users = User.find_by_sql("SELECT * FROM users WHERE firstname LIKE '%#{params[:search]}%'")
     render 'search'
  end

  def show
    if params[:id]
      @recipe = Recipe.find(params[:id])
    else
      @recipe = Recipe.find(params[:recipe_id])
    end
    if @recipe == nil
      flash[:error] = "No such recipe exists"
    end
    @favourite = Favourite.new
    @delete = Recipe.new
  end

  def favourite
    begin
      favourite_params =  params.require(:favourite).permit(:recipe_id)
      @favourite = Favourite.new(favourite_params)
      @favourite.user = @current_user
      if @favourite.save!
        redirect_to favourites_path()
      end
    rescue => e
      flash[:error] = e.message
      redirect_to favourites_path()
    end
  end

  def unfavourite
    unfavourite_params = params.require(:favourite).permit(:recipe_id)
    @unfavourite = Favourite.where("recipe_id = ? AND user_id = ?", unfavourite_params[:recipe_id], @current_user.id).take
    @unfavourite.destroy
    @unfavourite.save

    redirect_to favourites_path()
  end

  def favourites

  end

  def category
    @recipes = nil
  end

  def category_result
    category_params = params.require(:category).permit(:id)
    @recipes = Recipe.where("category_id =?", category_params[:id])

    render 'category'
  end

end
