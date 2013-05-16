require 'spec_helper'


describe TariffsController do
  let(:valid_attributes) { attributes_for(:tariff) }

  def valid_session
    {}
  end

  before do
    signed_in_as_a_valid_user
  end

  describe 'GET index' do
    it 'assigns all tariffs as @tariffs' do
      tariff = Tariff.create! valid_attributes
      get :index, {}, valid_session
      assigns(:tariffs).should eq([tariff])
    end
  end

  describe 'GET show' do
    it 'assigns the requested tariff as @tariff' do
      tariff = Tariff.create! valid_attributes
      get :show, {:id => tariff.to_param}, valid_session
      assigns(:tariff).should eq(tariff)
    end
  end

  describe 'GET new' do
    it 'assigns a new tariff as @tariff' do
      get :new, {}, valid_session
      assigns(:tariff).should be_a_new(Tariff)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested tariff as @tariff' do
      tariff = Tariff.create! valid_attributes
      get :edit, {:id => tariff.to_param}, valid_session
      assigns(:tariff).should eq(tariff)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Tariff' do
        expect {
          post :create, {:tariff => valid_attributes}, valid_session
        }.to change(Tariff, :count).by(1)
      end

      it 'assigns a newly created tariff as @tariff' do
        post :create, {:tariff => valid_attributes}, valid_session
        assigns(:tariff).should be_a(Tariff)
        assigns(:tariff).should be_persisted
      end

      it 'redirects to all tariffs' do
        post :create, {:tariff => valid_attributes}, valid_session
        response.should redirect_to(tariffs_path)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved tariff as @tariff' do
        # Trigger the behavior that occurs when invalid params are submitted
        Tariff.any_instance.stub(:save).and_return(false)
        post :create, {:tariff => {  }}, valid_session
        assigns(:tariff).should be_a_new(Tariff)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Tariff.any_instance.stub(:save).and_return(false)
        post :create, {:tariff => {  }}, valid_session
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested tariff' do
        tariff = Tariff.create! valid_attributes
        # Assuming there are no other tariffs in the database, this
        # specifies that the Tariff created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Tariff.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => tariff.to_param, :tariff => { "these" => "params" }}, valid_session
      end

      it 'assigns the requested tariff as @tariff' do
        tariff = Tariff.create! valid_attributes
        put :update, {:id => tariff.to_param, :tariff => valid_attributes}, valid_session
        assigns(:tariff).should eq(tariff)
      end

      it 'redirects to all tariffs' do
        tariff = Tariff.create! valid_attributes
        put :update, {:id => tariff.to_param, :tariff => valid_attributes}, valid_session
        response.should redirect_to(tariffs_path)
      end
    end

    describe 'with invalid params' do
      it 'assigns the tariff as @tariff' do
        tariff = Tariff.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Tariff.any_instance.stub(:save).and_return(false)
        put :update, {:id => tariff.to_param, :tariff => {  }}, valid_session
        assigns(:tariff).should eq(tariff)
      end

      it "re-renders the 'edit' template" do
        tariff = Tariff.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Tariff.any_instance.stub(:save).and_return(false)
        put :update, {:id => tariff.to_param, :tariff => {  }}, valid_session
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested tariff' do
      tariff = Tariff.create! valid_attributes
      expect {
        delete :destroy, {:id => tariff.to_param}, valid_session
      }.to change(Tariff, :count).by(-1)
    end

    it 'redirects to the tariffs list' do
      tariff = Tariff.create! valid_attributes
      delete :destroy, {:id => tariff.to_param}, valid_session
      response.should redirect_to(tariffs_url)
    end
  end

end
