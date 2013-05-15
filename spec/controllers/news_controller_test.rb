require 'spec_helper'

describe NewsController  do

  before(:each) do
    @tariff = create(:tariff)
  end

  it 'should get index' do
    get :index
    assert_response :success
  end

  it 'should get show' do
    get :show
    assert_response :success
  end

end
