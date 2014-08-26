class CreatePatientAppointments < ActiveRecord::Migration
  def change
    create_table :patient_appointments do |t|
      t.time :start_time
      t.time :end_time
      t.boolean :appointment_booked
      t.date :date
      t.references :user, index: true
      t.references :dr_availability, index: true

      t.timestamps
    end
  end
end