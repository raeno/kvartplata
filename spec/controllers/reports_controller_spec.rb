require 'spec_helper'

describe ReportsController do

  let(:valid_attributes) { attributes_for(:report, date: DateTime.new(2012,3,2).round_to_month) }
  let(:report) { create :report }

  describe 'GET index' do

    context 'when not logged in' do
      it 'redirects to sign in page' do
        get :index
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user }

      describe 'assigns all reports as reports_by_year' do
        before do
          @report = Report.create! valid_attributes
          get :index, {}
          @reports =  assigns(:reports_by_year)
        end

        it { @reports.should be_kind_of Hash }
        it { @reports.count.should == 1 }
        it { @reports[2012].should be_kind_of Hash }
        it { @reports[2012].count.should == 1 }
        it { @reports[2012][3].should eq [@report] }
      end
    end
  end

  describe 'GET show' do
    context 'when not logged in' do
      it 'redirects to sign in page' do
        get :show, :month => report.date.month, :year => report.date.year
        response.should redirect_to new_user_session_path
      end
    end

    context 'when logged in' do
      before { signed_in_as_a_valid_user }

      it 'assigns the requested report as @report' do
        get :show, { :month => report.date.month, :year => report.date.year }
        assigns(:report).should eq(report)
      end
    end
  end
end
