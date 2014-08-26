module ApplicationHelper

  def time_booked?(time, date, dr_availability_id)
    appt = PatientAppointment.find_by(start_time: time)
    if appt
      if (appt.date == date) && (appt.dr_availability_id = dr_availability_id)
        return true
      else
        return false
      end
    end
  end

  def find_respective_doctor(appointment)
    dr_availability = DrAvailability.find(appointment.dr_availability_id)
    User.find(dr_availability.doctor_id)
  end

  def find_day_from_preference(appointment)
    dr_availability = DrAvailability.find(appointment.dr_availability_id)
    dr_availability.day
  end
end
