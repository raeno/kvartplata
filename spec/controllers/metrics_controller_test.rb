require 'spec_helper'

describe MetricsController do
  before(:each) do
    @metric = create(:metric)
    sign_in create(:user)
  end

  it 'should get index' do
    get :index
    assert_response :success
    assigns(:metrics).should.not == nil
  end

  it 'should correctly return page if locale supported' do
    get :index, :locale => 'ru'
    assert_response :success
    assigns(:metrics).should.not == nil
  end

  it 'should show notice when locale is not supported' do
    get :index, :locale => 'br'
    assert_response :success
    flash[:notice].should.not == nil
    'br translation not available'.should == flash[:notice]
    assigns(:metrics).should.not == nil
  end

  it 'should get new' do
    get :new
    assert_response :success
  end

  it 'should create metric' do
    assert_difference 'Metric.count', +1 do
      post :create, metric: FactoryGirl.attributes_for(:metric)
    end
    assert_redirected_to Report.last.month_year_path
  end

  it 'redirect to a new metric if report' do
    assert_difference 'Metric.count', +1 do
      post :create, metric: FactoryGirl.attributes_for(:metric)
    end
    assert_redirected_to Report.last.month_year_path
  end



  it 'should render new metric form if validations failed for metric' do
    assert_no_difference('Metric.count') do
      post :create, metric: FactoryGirl.attributes_for(:metric, :hot_counter_kitchen => -2)
    end
    assert_template 'new'
  end

  it 'should show metric' do
    get :show, id: @metric
    assert_response :success
  end

  it 'should get edit' do
    get :edit, id: @metric
    assert_response :success
  end

  it 'should update metric' do
    put :update, id: @metric, metric: {  }
    assert_redirected_to metric_path(assigns(:metric))
  end

  it 'should redirect to metric edit if metric validations failed' do
    put :update, id: @metric, metric: { :hot_counter_kitchen => -2}
    assert_response :success
    assert_template 'edit'
  end


  it 'should destroy metric' do
    assert_difference('Metric.count', -1) do
      delete :destroy, id: @metric
    end

    assert_redirected_to metrics_path
  end


end
