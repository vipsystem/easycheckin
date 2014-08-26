class AppointmentBooker

  def get_day_of_the_week(date)
    date.to_date.strftime("%A").downcase!
  end

  def get_current_doctor_availability(date)
    dr_availability = DrAvailability.find_by(doctor_id: @current_doctor, day: get_day_of_the_week(date))
  end

  def initialize(params, good_params, current_user, current_doctor)
    @params = params
    @good_params = good_params
    @current_user = current_user
    @current_doctor = current_doctor
  end
    
  def do_the_booking  
    date = @params[:patient_appointment][:date]
    @dr_availability = get_current_doctor_availability(date)
    @patient_appointment = PatientAppointment.new(@good_params)
    @patient_appointment.dr_availability_id = @dr_availability.id
    @patient_appointment.user_id = @current_user.id
    @patient_appointment.appointment_booked = true
    if @patient_appointment.save
      NewAppointmentMailer.new_appointment_email(@patient_appointment).deliver
      @patient_appointment
    else
      nil
    end
  end
end