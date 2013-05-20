require 'spec_helper'

describe SettingsController do

  before { create :tariff }

  describe 'GET index' do

    context 'when not logged in' do
      it 'redirects to sign in page' do
        get :index
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do

      before { signed_in_as_a_valid_user }

      it 'assigns current_user as user' do
        get :index
        response.should be_success
      end
    end
  end
end