require 'test_helper'

class TariffesControllerTest < ActionController::TestCase
  setup do
    @tariffe = tariffes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tariffes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tariffe" do
    assert_difference('Tariffe.count') do
      post :create, tariffe: {  }
    end

    assert_redirected_to tariffe_path(assigns(:tariffe))
  end

  test "should show tariffe" do
    get :show, id: @tariffe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tariffe
    assert_response :success
  end

  test "should update tariffe" do
    put :update, id: @tariffe, tariffe: {  }
    assert_redirected_to tariffe_path(assigns(:tariffe))
  end

  test "should destroy tariffe" do
    assert_difference('Tariffe.count', -1) do
      delete :destroy, id: @tariffe
    end

    assert_redirected_to tariffes_path
  end
end
