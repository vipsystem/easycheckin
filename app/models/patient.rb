class Patient < User
  has_many :patient_appointments
end