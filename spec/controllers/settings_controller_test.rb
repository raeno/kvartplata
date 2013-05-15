require 'spec_helper'

describe SettingsController do

  before(:each) do
    sign_in create(:user)
    create :tariff
  end

  it 'should get index' do
    get :index
    assert_response :success
  end
end