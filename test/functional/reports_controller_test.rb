require 'test_helper'

class ReportsControllerTest < ActionController::TestCase

  setup do
    @report = create(:report_with_metrics)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @report
    assert_response :success
  end

end
