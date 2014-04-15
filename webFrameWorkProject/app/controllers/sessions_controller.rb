class SessionsController < ApplicationController
  def new
    render 'new'	
  end

  def create
    session_params = params.require(:session)
    user = User.authenticate(session_params[:email], session_params[:submitted_password])
    
    if user
      session[:user_id] = user.id
      redirect_to user_path(:id => user.id)
 
    else
      flash[:notice] = "Login unsuccessful"
      render "new"
    end
  
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
 
  end
end
