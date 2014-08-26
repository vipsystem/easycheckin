class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.time :start_time
      t.date :date
      t.references :patient_appointment, index: true

      t.timestamps
    end
  end
end
