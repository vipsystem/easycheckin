class PatientAppointmentsController < ApplicationController  

  include PatientAppointmentsConcern

  before_action :check_current_doctor
  before_action :check_user_login

  respond_to :html, :json

  def index
    if @current_user.type=="Patient"
      @patient_appointments = PatientAppointment.where(user_id: @current_user.id)
    elsif @current_user.type=="Doctor"
      all_patient_appointments = PatientAppointment.all
      @patient_appointments=[]
      all_patient_appointments.each do |appointment|
        if find_respective_doctor(appointment) == @current_user
          @patient_appointments.push(appointment)
        end
      end
    end
    @patient_appointments = @patient_appointments.sort_by{|appointment| appointment.date}
  end

  def show
    @patient_appointment = PatientAppointment.find(params[:id])
    @doctor = get_desired_doctor(@patient_appointment)
    session[:current_doctor] = @doctor
  end

  def new
    if params[:replaced_appointment]
      @patient_appointment = PatientAppointment.new(start_time: params[:start_time], date:params[:date])
      PatientAppointment.find(params[:replaced_appointment]).delete
    else
      @patient_appointment = PatientAppointment.new(start_time: params[:time], date: params[:date], user_id: @current_user, dr_availability_id: @dr_availability, appointment_booked: true)
    end
  end

  def create
    @patient_appointment = AppointmentBooker.new(params, patient_appointment_params, @current_user, @current_doctor).do_the_booking
    redirect_to patient_appointment_path(@patient_appointment)
  end

  def destroy 
    @cancelled_appointment = PatientAppointment.find(params[:id])
    @appt_id = @cancelled_appointment.id
    Preference.delete_all(patient_appointment_id: @appt_id)
    send_mail_to_replacement_patients(@cancelled_appointment)    
    @cancelled_appointment.delete
    respond_to do |format|
      format.js
    end
  end

  private

  def patient_appointment_params
    params.require(:patient_appointment).permit(:start_time, :date)
  end

  def find_respective_doctor(appointment)
    dr_availability = DrAvailability.find(appointment.dr_availability_id)
    User.find(dr_availability.doctor_id)
  end

end
