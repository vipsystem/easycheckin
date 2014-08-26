class CreateDrAvailabilities < ActiveRecord::Migration
  def change
    create_table :dr_availabilities do |t|
      t.time :clinic_open
      t.time :clinic_close
      t.string :day
      t.integer :avg_appt_time
      t.references :doctor, index: true

      t.timestamps
    end
  end
end