require 'test_helper'

class BoilersControllerTest < ActionController::TestCase
  setup do
    @boiler = boilers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boilers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boiler" do
    assert_difference('Boiler.count') do
      post :create, boiler: {  }
    end

    assert_redirected_to boiler_path(assigns(:boiler))
  end

  test "should show boiler" do
    get :show, id: @boiler
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boiler
    assert_response :success
  end

  test "should update boiler" do
    patch :update, id: @boiler, boiler: {  }
    assert_redirected_to boiler_path(assigns(:boiler))
  end

  test "should destroy boiler" do
    assert_difference('Boiler.count', -1) do
      delete :destroy, id: @boiler
    end

    assert_redirected_to boilers_path
  end
end
