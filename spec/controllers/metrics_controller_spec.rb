require 'spec_helper'

describe MetricsController do

  let(:valid_attributes) { attributes_for(:metric) }

  before do
    create :tariff
  end


  describe 'GET #index' do
    context 'when not logged in' do
      before { get :index }
      it 'redirects to sign in page' do
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user }

      it 'populates an array of metrics' do
        metric = create :metric
        get :index
        assigns(:metrics).should eq([metric])
      end

      it 'succeeds' do
        get :index
        response.should be_success
      end
    end
  end

  describe 'GET #new' do

    context 'when not logged in' do
      before { get :new }

      it 'redirects to sign in page' do
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user }

      it 'assigns new_metric as @metric' do
        get :new
        assigns(:metric).should be_a_new(Metric)
      end

      it 'succeeds' do
        get :new
        response.should be_success
      end
    end


  end

  describe 'GET #edit' do

    let(:metric) { create :metric }

    context 'when not logged in' do
      it 'redirects to sign in page' do
        get :edit, :id => metric.to_param
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user }

      it 'assigns the requested metric as @metric' do
        get :edit, {:id => metric.to_param}
        assigns(:metric).should eq(metric)
      end

    end
  end

  describe 'POST #create' do

    context 'when not logged in' do
      it 'redirects to sign in page' do
        post :create, :metric => valid_attributes
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user }

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

        context 'when report can be created' do
          before { create :metric }

          it 'creates a new report' do
            expect {
              post :create, {:metric => valid_attributes }
            }.to change(Report, :count).by(1)
          end

          it 'makes created report available from metric' do
            post :create, {:metric => valid_attributes }
            assigns(:metric).report.should be_a(Report)
          end

          it 'redirects to created report' do
            post :create, { :metric => valid_attributes }
            report = assigns(:metric).report
            response.should redirect_to report.month_year_path
          end
        end

        context 'when report cannot be created' do
          it 'redirects to new metric' do
            post :create, {:metric => valid_attributes}
            response.should redirect_to(new_metric_path)
          end
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved metric as @metric' do
          Metric.any_instance.stub(:save).and_return(false)
          post :create, {:metric => {  }}
          assigns(:metric).should be_a_new(Metric)
        end

        it 're-renders the _new_ template' do
          Metric.any_instance.stub(:save).and_return(false)
          post :create, {:metric => {  }}
          response.should render_template :new
        end
      end
    end
  end

  describe 'PUT update' do

    let(:metric) { create :metric }

    context 'when not logged in' do

      it 'redirects to sign in page' do
        put :update, {:id => metric.to_param, :metric => { 'these' => 'params'}}
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user}

      describe 'with valid params' do

        it 'updates the requested metric' do
          Metric.any_instance.should_receive(:update_attributes).with({ 'these' => 'params'})
          put :update, {:id => metric.to_param, :metric => { 'these' => 'params'}}
        end

        it 'assigns the requested metric as @metric' do
          metric = Metric.create! valid_attributes
          put :update, {:id => metric.to_param, :metric => valid_attributes}
          assigns(:metric).should eq(metric)
        end

        context 'when applied to metric associated with report' do

          before do
            create :metric
            create :metric
            @metric = create :metric
          end

          it 'does not create new report' do
            expect {
              put :update, { :id => @metric.to_param, :metric => {:hot_counter_kitchen => 100}}
            }.to_not change(Report,:count)
          end

        end

        context 'when no associated report for metric' do
          before do
            Metric.delete_all
          end

          it 'redirects to new_metric' do
            metric = Metric.create! valid_attributes
            put :update, {:id => metric.to_param, :metric => valid_attributes}
            response.should redirect_to new_metric_path
          end
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
  end

  describe 'DELETE destroy' do
    let(:metric) { create :metric }

    context 'when not logged in' do
      it 'redirects to sign in page' do
        delete :destroy, {:id => metric.to_param}
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user}

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
end
