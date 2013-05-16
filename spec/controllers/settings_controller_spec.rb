require 'spec_helper'

describe SettingsController do

  before do
    signed_in_as_a_valid_user
    create :tariff
  end

  it 'should get index' do
    get :index
    response.should be_success
  end
end