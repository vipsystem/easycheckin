# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140825201928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breaks", force: true do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "repeat"
    t.date     "date"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "breaks", ["doctor_id"], name: "index_breaks_on_doctor_id", using: :btree

  create_table "dr_availabilities", force: true do |t|
    t.time     "clinic_open"
    t.time     "clinic_close"
    t.string   "day"
    t.integer  "avg_appt_time"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dr_availabilities", ["doctor_id"], name: "index_dr_availabilities_on_doctor_id", using: :btree

  create_table "patient_appointments", force: true do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "appointment_booked"
    t.date     "date"
    t.integer  "user_id"
    t.integer  "dr_availability_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patient_appointments", ["dr_availability_id"], name: "index_patient_appointments_on_dr_availability_id", using: :btree
  add_index "patient_appointments", ["user_id"], name: "index_patient_appointments_on_user_id", using: :btree

  create_table "preferences", force: true do |t|
    t.time     "start_time"
    t.date     "date"
    t.integer  "patient_appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["patient_appointment_id"], name: "index_preferences_on_patient_appointment_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "phone_number",    limit: 8
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "password_digest"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
