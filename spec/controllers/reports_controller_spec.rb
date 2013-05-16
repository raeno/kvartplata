require 'spec_helper'

describe ReportsController do

  let(:valid_attributes) { attributes_for(:report, date: DateTime.new(2012,3,2).round_to_month) }

  before do
    @apartment_info = create(:apartment_info)
    signed_in_as_a_valid_user
  end


  describe 'GET index' do
    context 'assigns all reports as reports_by_year' do
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

  describe 'GET show' do
    it 'assigns the requested report as @report' do
      report = Report.create! valid_attributes
      get :show, { :month => report.date.month, :year => report.date.year }
      assigns(:report).should eq(report)
    end
  end



end
