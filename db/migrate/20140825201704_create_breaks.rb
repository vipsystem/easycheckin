class CreateBreaks < ActiveRecord::Migration
  def change
    create_table :breaks do |t|
      t.time :start_time
      t.time :end_time
      t.boolean :repeat
      t.date :date
      t.references :doctor, index: true

      t.timestamps
    end
  end
end