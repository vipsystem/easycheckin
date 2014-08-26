class UsersController < ApplicationController

  before_action :check_user_login, :check_current_doctor, except: [:new, :create]
  before_action :check_dr_schedule_made, except: [:new, :create]
  
  def index
    @doctors = User.where(type: "Doctor")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_users_path
    else
      render :new
    end
  end

  def show
    if !@current_user
      redirect_to login_users_path
      @dr_availabilities = DrAvailability.where(id: @current_user)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render text: "record updated."
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation, :city, :state, :zip_code, :address, :type)
  end 
end
