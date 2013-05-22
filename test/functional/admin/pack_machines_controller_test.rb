require 'test_helper'

class Admin::PackMachinesControllerTest < ActionController::TestCase
  setup do
    @admin_pack_machine = admin_pack_machines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_pack_machines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_pack_machine" do
    assert_difference('PackMachine.count') do
      post :create, admin_pack_machine: @admin_pack_machine.attributes
    end

    assert_redirected_to admin_pack_machine_path(assigns(:admin_pack_machine))
  end

  test "should show admin_pack_machine" do
    get :show, id: @admin_pack_machine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_pack_machine
    assert_response :success
  end

  test "should update admin_pack_machine" do
    put :update, id: @admin_pack_machine, admin_pack_machine: @admin_pack_machine.attributes
    assert_redirected_to admin_pack_machine_path(assigns(:admin_pack_machine))
  end

  test "should destroy admin_pack_machine" do
    assert_difference('PackMachine.count', -1) do
      delete :destroy, id: @admin_pack_machine
    end

    assert_redirected_to admin_pack_machines_path
  end
end
