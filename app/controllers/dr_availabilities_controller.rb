class DrAvailabilitiesController < ApplicationController

  include DrAvailabilitiesConcern

  before_action :check_current_doctor
  before_action :check_user_login

  respond_to :html, :json

  def index
    @dr_availabilities = DrAvailability.where(doctor_id: @current_doctor)
    respond_with @dr_availabilities
  end

  def show
    @current_date = params[:clicked_date]
    if @current_date 
      @current_day = get_day_of_week_from_date(@current_date)
      @appointment_times = split_schedule_into_appts(@current_day)
      @dr_availability = @current_schedule
      render "show", layout: false
    end
  end

  def new
    if @current_user.type == "Doctor"
      @dr_availability = DrAvailability.new
      @days_of_the_week = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    # else 
    #   redirect_to login_users_path, notice: "You must me logged in as a Doctor to create a new Dr Schedule"
    end
  end

  def create
    create_availabilities_for_each_day(params)
    redirect_to dr_availabilities_path
  end

  def edit
    @days_of_the_week = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    @dr_availabilities = DrAvailability.find(params[:id])
  end

  private

  def dr_availability_params
    params.require(:dr_availability).permit(:clinic_open, :clinic_close, :avg_appt_time, :day)
  end

end