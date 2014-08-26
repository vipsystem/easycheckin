class SessionsController < ApplicationController
  before_action :check_user_login, except: [:create, :destroy]
  
  def new
      if @current_user
        redirect_to user_path(@current_user)
      else
        @user = User.new
      end
  end

  def create
    @user = User.find_by(email: params[:user][:email]) 

    if @user && @user.authenticate(params[:user][:password])
      if @user.type == 'Doctor'
        session[:doctor_id] = @user.id
        redirect_to user_path(@user)
      elsif @user.type == 'Patient'
        session[:patient_id] = @user.id
        redirect_to user_path(@user)
      end
    else
      flash[:error] = "Invalid login, please try again."
      redirect_to login_users_path
    end
  end

  def destroy
    reset_session
    redirect_to login_users_path
  end


end