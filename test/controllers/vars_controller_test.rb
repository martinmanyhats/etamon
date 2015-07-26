require 'test_helper'

class VarsControllerTest < ActionController::TestCase
  setup do
    @var = vars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create var" do
    assert_difference('Var.count') do
      post :create, var: { boiler: @var.boiler, lastSetDate: @var.lastSetDate, name: @var.name, varNames: @var.varNames }
    end

    assert_redirected_to var_path(assigns(:var))
  end

  test "should show var" do
    get :show, id: @var
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @var
    assert_response :success
  end

  test "should update var" do
    patch :update, id: @var, var: { boiler: @var.boiler, lastSetDate: @var.lastSetDate, name: @var.name, varNames: @var.varNames }
    assert_redirected_to var_path(assigns(:var))
  end

  test "should destroy var" do
    assert_difference('Var.count', -1) do
      delete :destroy, id: @var
    end

    assert_redirected_to vars_path
  end
end
