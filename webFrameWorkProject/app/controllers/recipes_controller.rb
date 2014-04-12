class RecipesController < ApplicationController
  
  def new
	 @recipe = Recipe.new
  end
  
  def create
    recipe_params = params.require(:recipe)#.permit(:avatar)
  	@recipe = Recipe.new(:title => recipe_params[:title], :ingredients => recipe_params[:ingredients], 
                          :instructions => recipe_params[:instructions], :feed_id => @current_user.feed.id, 
                          :category_id => recipe_params[:category_id])
    #@recipe = Recipe.new(recipe_params, :feed_id => @current_user.feed.id)
  	if @recipe.save!
      flash[:notice] = "Recipe saved"
      redirect_to profile_path

    else
      flash[:notice] = "Recipe not saved"
      render new
    end
  end

  def delete
  	@recipe = Recipes.destroy
  end

  def search
    @page_header = "Latest recipes"
    @recipes = Recipe.all.reverse
    #@user = Recipe.feed.users.email
  end
  
  def results
     search_param = params[:search]
     @page_header = "Search results for: #{search_param}" 
     @recipes = Recipe.where("title = ?", params[:search])
     render 'search'
  end

  def show
    @recipe = Recipe.find(params[:id])
    if @recipe == nil
      flash.now[:error] = "No such recipe exists"
    end

    @favourite = Favourite.new
  end

  def favourite
    favourite_params =  params.require(:favourite).permit(:recipe_id)
    @favourite = Favourite.new(favourite_params)
    @favourite.user = @current_user
    if @favourite.save!
      redirect_to favourites_path()
    else
      flash.now[:error] = "Something went wrong"
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

end
