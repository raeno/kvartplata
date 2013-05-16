require 'spec_helper'

describe MetricsController do
  let(:valid_attributes) { attributes_for(:metric) }

  let(:user) { create :user }

  before do
    sign_in user
  end

  describe 'GET index' do
    it 'assigns all metrics as @metrics' do
      metric = Metric.create! valid_attributes
      get :index
      assigns(:metrics).should eq([metric])
    end
  end

  describe 'GET show' do
    it 'assigns the requested metric as @metric' do
      metric = Metric.create! valid_attributes
      get :show, {:id => metric.to_param}
      assigns(:metric).should eq(metric)
    end
  end

  describe 'GET new' do
    it 'assigns a new metric as @metric' do
      get :new, {}
      assigns(:metric).should be_a_new(Metric)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested metric as @metric' do
      metric = Metric.create! valid_attributes
      get :edit, {:id => metric.to_param}
      assigns(:metric).should eq(metric)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Metric' do
        expect {
          post :create, {:metric => valid_attributes}
        }.to change(Metric, :count).by(1)
      end

      it 'assigns a newly created metric as @metric' do
        post :create, {:metric => valid_attributes}
        assigns(:metric).should be_a(Metric)
        assigns(:metric).should be_persisted
      end

      it 'redirects to new metric' do
        post :create, {:metric => valid_attributes}
        response.should redirect_to(new_metric_path)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved metric as @metric' do
        # Trigger the behavior that occurs when invalid params are submitted
        Metric.any_instance.stub(:save).and_return(false)
        post :create, {:metric => {  }}
        assigns(:metric).should be_a_new(Metric)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Metric.any_instance.stub(:save).and_return(false)
        post :create, {:metric => {  }}
        response.should render_template("new")
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested metric' do
        metric = Metric.create! valid_attributes
        # Assuming there are no other metrics in the database, this
        # specifies that the Metric created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Metric.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => metric.to_param, :metric => { "these" => "params" }}
      end

      it 'assigns the requested metric as @metric' do
        metric = Metric.create! valid_attributes
        put :update, {:id => metric.to_param, :metric => valid_attributes}
        assigns(:metric).should eq(metric)
      end

      it 'redirects to new_metric' do
        metric = Metric.create! valid_attributes
        put :update, {:id => metric.to_param, :metric => valid_attributes}
        response.should redirect_to(metric)
      end
    end

    describe 'with invalid params' do
      it 'assigns the metric as @metric' do
        metric = Metric.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Metric.any_instance.stub(:save).and_return(false)
        put :update, {:id => metric.to_param, :metric => {  }}
        assigns(:metric).should eq(metric)
      end

      it "re-renders the 'edit' template" do
        metric = Metric.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Metric.any_instance.stub(:save).and_return(false)
        put :update, {:id => metric.to_param, :metric => {  }}
        response.should render_template("edit")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested metric' do
      metric = Metric.create! valid_attributes
      expect {
        delete :destroy, {:id => metric.to_param}
      }.to change(Metric, :count).by(-1)
    end

    it 'redirects to the metrics list' do
      metric = Metric.create! valid_attributes
      delete :destroy, {:id => metric.to_param}
      response.should redirect_to(metrics_url)
    end
  end

end
