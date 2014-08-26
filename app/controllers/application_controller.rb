class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper :all

  #setting @current_user variable to be used in UsersController based on which session was created

  def check_user_login
     if session[:patient_id]
       @current_user = User.find(session[:patient_id])
       @dr_schedule_made = []
     elsif session[:doctor_id]
       @current_user = User.find(session[:doctor_id])
       @dr_schedule_made = DrAvailability.where(doctor_id: @current_user)
     end
  end

  def check_current_doctor
    if session[:doctor_id]
      @current_doctor = User.find(session[:doctor_id])
    else
      @current_doctor = params[:doctor_id]
    end
  end

  def check_dr_schedule_made
    if @current_user
      if @current_user.type=="Doctor" && !@dr_schedule_made.any?
        redirect_to new_dr_availability_path
      end
    end
  end
end
