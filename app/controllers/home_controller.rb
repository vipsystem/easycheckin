class HomeController < ApplicationController

  before_action :check_user_login
  
  def index
    if @current_user
      redirect_to user_path(@current_user)
    end
  end
  
end