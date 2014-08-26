require 'test_helper'

class PatientAppointmentsControllerTest < ActionController::TestCase
  test "should get start_time:time" do
    get :start_time:time
    assert_response :success
  end

  test "should get end_time:time" do
    get :end_time:time
    assert_response :success
  end

  test "should get appointment_booked:boolean" do
    get :appointment_booked:boolean
    assert_response :success
  end

  test "should get date:date" do
    get :date:date
    assert_response :success
  end

  test "should get user:references:add_index:boolean" do
    get :user:references:add_index:boolean
    assert_response :success
  end

end
