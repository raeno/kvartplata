require 'spec_helper'

describe TariffsController do
  before(:each) do
    @tariff = create(:tariff)
    sign_in create(:user)
  end

  it 'should get index' do
    get :index
    assert_response :success
    assigns(:tariffs).should.not == nil
  end

  it 'should get new' do
    get :new
    assert_response :success
  end

  it 'should create tariff' do
    assert_difference('Tariff.count') do
      post :create, tariff: FactoryGirl.attributes_for(:tariff)
    end
    assert_redirected_to tariffs_path
  end

  it 'should render tariff/new tamplate if tariff creation failed' do
    assert_no_difference('Tariff.count') do
      post :create, tariff: FactoryGirl.attributes_for(:tariff, :energy => -2)
    end

    assert_response :success
    assert_template 'new'
  end

  it 'should show tariff' do
    get :show, id: @tariff
    assert_response :success
  end

  it 'should get edit' do
    get :edit, id: @tariff
    assert_response :success
  end

  it 'should update tariff' do
    put :update, id: @tariff, tariff: {  }
    assert_redirected_to tariffs_path
  end

  it 'should render tariff/edit template if tariff validations failed' do
    put :update, id: @tariff, tariff: { :energy => -2}
    assert_response :success
    assert_template 'edit'
  end

  it 'should destroy tariff' do
    assert_difference('Tariff.count', -1) do
      delete :destroy, id: @tariff
    end

    assert_redirected_to tariffs_path
  end
end
