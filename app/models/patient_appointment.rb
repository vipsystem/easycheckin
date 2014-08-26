class PatientAppointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :dr_availability

  validates :date, uniqueness: { scope: :start_time }
end