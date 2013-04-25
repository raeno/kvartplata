require 'test_helper'

class SettingsControllerTest < ActionController::TestCase

  setup do
    sign_in create(:user)
  end

  test 'should get index' do
    get :index
    assert_response :success

  end
end
