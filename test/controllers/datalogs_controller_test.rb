require 'test_helper'

class DatalogsControllerTest < ActionController::TestCase
  setup do
    @datalog = datalogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:datalogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create datalog" do
    assert_difference('Datalog.count') do
      post :create, datalog: { boiler_id: @datalog.boiler_id, values: @datalog.values }
    end

    assert_redirected_to datalog_path(assigns(:datalog))
  end

  test "should show datalog" do
    get :show, id: @datalog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @datalog
    assert_response :success
  end

  test "should update datalog" do
    patch :update, id: @datalog, datalog: { boiler_id: @datalog.boiler_id, values: @datalog.values }
    assert_redirected_to datalog_path(assigns(:datalog))
  end

  test "should destroy datalog" do
    assert_difference('Datalog.count', -1) do
      delete :destroy, id: @datalog
    end

    assert_redirected_to datalogs_path
  end
end
