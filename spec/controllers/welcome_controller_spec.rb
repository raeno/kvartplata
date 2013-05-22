require 'spec_helper'

describe WelcomeController do

  before { create :tariff }
  after { Timecop.return }

  context 'when user not logged in' do
    it 'redirects to sign_in' do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

  context 'when user logged in' do
    before {  signed_in_as_a_valid_user }

    context 'when payment date is near' do
      before do
         date = 5.years.since.change(:day => Metric::PAYMENT_DAY)
         Timecop.freeze(date)
      end

      context 'and no metric for this month' do
        it 'redirects to new metric' do
          get :index
          response.should redirect_to new_metric_path
        end
      end

      context 'and metric already exists' do
        before do
          create(:apartment_info)

          create(:metric, month: 2.month.ago)
          create(:metric, month: 1.month.ago)
          create(:metric, month: DateTime.now)
        end

        it 'shows report' do
          get :index
          response.should be_success
        end
      end
    end
  end
end
