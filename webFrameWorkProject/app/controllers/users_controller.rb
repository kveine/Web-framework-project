class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    begin
      user_params = params.require(:user).permit(:firstname, :surname, :email, :password, :password_confirmation, :avatar)
      @user = User.new(user_params)
      if @user.save!
        @feed = Feed.new
        @feed.user = @current_user
        @feed.save!
        @user.feed = @feed
        @user.save!
        flash.now[:notice] = "Signup successful"
        redirect_to log_in_path
      else
    	   render "new"
    	   flash.now[:notice] = "Signup unsuccessful"
      end
    rescue => e
      flash[:error] = e.message
    end
  end
  
  def show
    @current_user_recipes = @current_user.feed.recipes
    
  end
end
