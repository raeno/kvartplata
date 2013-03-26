require 'test_helper'

class MetricsControllerTest < ActionController::TestCase
  setup do
    @metric = create(:metric)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:metrics)
  end

  test 'should correctly return page if locale supported' do
    get :index, :locale => 'ru'
    assert_response :success
    assert_not_nil assigns(:metrics)
  end

  test 'should show notice when locale is not supported' do
    get :index, :locale => 'br'
    assert_response :success
    assert flash[:notice]
    assert_equal flash[:notice], 'br translation not available'
    assert_not_nil assigns(:metrics)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create metric' do
    assert_difference('Metric.count') do
      post :create, metric: FactoryGirl.attributes_for(:metric)
    end
    assert_redirected_to Report.last
  end

  test 'should render new metric form if validations failed for metric' do
    assert_no_difference('Metric.count') do
      post :create, metric: FactoryGirl.attributes_for(:metric, :hot_counter_kitchen => -2)
    end
    assert_template 'new'
  end

  test 'should show metric' do
    get :show, id: @metric
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @metric
    assert_response :success
  end

  test 'should update metric' do
    put :update, id: @metric, metric: {  }
    assert_redirected_to metric_path(assigns(:metric))
  end

  test 'should redirect to metric edit if metric validations failed' do
    put :update, id: @metric, metric: { :hot_counter_kitchen => -2}
    assert_response :success
    assert_template 'edit'
  end


  test 'should destroy metric' do
    assert_difference('Metric.count', -1) do
      delete :destroy, id: @metric
    end

    assert_redirected_to metrics_path
  end


end
