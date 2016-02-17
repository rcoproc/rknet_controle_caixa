# require 'test_helper'
#
# class AccountAppointmentsControllerTest < ActionController::TestCase
#   setup do
#     @account_appointment = account_appointments(:one)
#   end
#
#   test "should get index" do
#     get :index
#     assert_response :success
#     assert_not_nil assigns(:account_appointments)
#   end
#
#   test "should get new" do
#     get :new
#     assert_response :success
#   end
#
#   test "should create account_appointment" do
#     assert_difference('AccountAppointment.count') do
#       post :create, account_appointment: { account: @account_appointment.account, date: @account_appointment.date, description: @account_appointment.description, document: @account_appointment.document, type: @account_appointment.type, value: @account_appointment.value }
#     end
#
#     assert_redirected_to account_appointment_path(assigns(:account_appointment))
#   end
#
#   test "should show account_appointment" do
#     get :show, id: @account_appointment
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get :edit, id: @account_appointment
#     assert_response :success
#   end
#
#   test "should update account_appointment" do
#     patch :update, id: @account_appointment, account_appointment: { account: @account_appointment.account, date: @account_appointment.date, description: @account_appointment.description, document: @account_appointment.document, type: @account_appointment.type, value: @account_appointment.value }
#     assert_redirected_to account_appointment_path(assigns(:account_appointment))
#   end
#
#   test "should destroy account_appointment" do
#     assert_difference('AccountAppointment.count', -1) do
#       delete :destroy, id: @account_appointment
#     end
#
#     assert_redirected_to account_appointments_path
#   end
# end
