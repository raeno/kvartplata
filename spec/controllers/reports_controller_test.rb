require 'spec_helper'

describe ReportsController do

  before(:each) do
    @report = create(:report_with_metrics)
    @apartment_info = create(:apartment_info)
    sign_in create(:user)
  end

  it 'should get index' do
    get :index
    assert_response :success
  end

  it 'should get show' do
    get :show, year: @report.date.year, month: @report.date.month
    assert_response :success
  end

end
