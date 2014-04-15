class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    begin
      user_params = params.require(:user).permit(:firstname, :surname, :email, :password, :password_confirmation, :avatar)
      @user = User.new(user_params)
      @user.valid?
      @user.errors.messages
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
      redirect_to sign_up_path()
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  
  def follow
    begin
      follow_params = params.require(:following).permit(:feed_id)
      @follow = Following.new(follow_params)
      @follow.user = @current_user
      if @follow.save!
        redirect_to following_path()
      end
    rescue => e
      flash[:error] = e.message
      redirect_to following_path()
    end
  end

  def unfollow
    unfollow_params = params.require(:following).permit(:feed_id)
    @unfollow = Following.where("feed_id = ? AND user_id = ?", unfollow_params[:feed_id], @current_user.id).take
    @unfollow.destroy
    @unfollow.save

    redirect_to following_path()
  end

  def following

  end

end
