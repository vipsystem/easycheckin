class PreferencesController < ApplicationController

  include PatientAppointmentsConcern

  before_action :check_current_doctor, except: [:create_preferences]
  before_action :check_user_login

  def new
    @new_preferences = PatientAppointment.new 
  end

  def create
    create_new_preferences(params)
    redirect_to patient_appointments_path
  end

  private 

  def preference_params
    params.require(:preferences).permit(:day, :start_time, :patient_appointment_id)
  end

end