class Preference < ActiveRecord::Base
  belongs_to :patient_appointment

  validates :start_time, :date, presence: true
end
