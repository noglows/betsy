class SessionsController < ApplicationController
  def new
  end

  def create
    data = params[:session_data]
    @user = User.find_by_email(data[:email])

    if !@user.nil?
      # User is in the system
      if @user.authenticate(data[:password])
        # User is Authenticated
        session[:user_id] = @user.id
        redirect_to root_path
      else
        # user is not Authenticated
        flash.now[:error] = "Hmmm, that password doesn't seem quite right..."
        render :new
      end
    else
      # User is not in the system
      flash[:error] = "We don't have that email address registered. Would you like to create a new account?"
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
