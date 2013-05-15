require 'spec_helper'


describe Report do

  context 'when we compute_total' do
    subject { build(:report, cold_water: 10, hot_water: 20, utilities: 30, energy: 40) }
    it { should respond_to :compute_total }
    its(:compute_total) { should be_same_float_as 10+20+30+40 }
  end

  context 'when we subtract one metric from another' do
    let(:report) { build :report_with_metrics }
    subject { report.current_metric - report.previous_metric }

    its(:hot_counter_kitchen)   { should be_same_float_as report.difference.hot_counter_kitchen }
    its(:cold_counter_kitchen)  { should be_same_float_as report.difference.cold_counter_kitchen }
    its(:hot_counter_bathroom)  { should be_same_float_as report.difference.hot_counter_bathroom }
    its(:cold_counter_bathroom) { should be_same_float_as report.difference.cold_counter_bathroom }
  end


  context 'when we look for utilities diff' do
    let(:report) { build(:report_with_metrics) }
    it { report.should respond_to :utilities_diff }
    it { report.utilities_diff.should be_same_float_as (report.current_metric.utilities - report.previous_metric.utilities) }
  end

  context 'when we create report from metric' do
    before do
      Metric.delete_all
      @previous_metric = create(:metric, month: 5.month.ago)
      @source_metric = create(:metric, month: 4.month.ago)
    end

    subject { Report.from_metric @source_metric }

    it { should_not be_nil }
    it { should respond_to :tariff}
    its(:tariff) { should_not be_nil }

    it { should respond_to :current_metric }
    it { should respond_to :previous_metric }
    its(:current_metric) { should == @source_metric }
    its(:previous_metric) { should == @previous_metric }
  end

  context 'when we want to group reports by months and year' do
    before do
      (1..4).each do |month|
        create(:report, :date => DateTime.now.change(:day =>1, :month => month, :year => 2013) )
      end

      (1..6).each do |month|
        create(:report, :date => DateTime.now.change(:day => 1, :month => month, :year => 2012))
      end

      @grouped_reports = Report.grouped_by_months
    end

    it { @grouped_reports.should be_a Hash }
    it { @grouped_reports.keys.should include 2013 }
    it { @grouped_reports.keys.should include 2012 }
    it { @grouped_reports.length.should == 2 }

    context '2013 year reports' do
      subject { @grouped_reports[2013] }
      its(:length) { should == 4}
    end

    context '2012 year reports' do
      subject { @grouped_reports[2012] }
      its(:length) { should == 6}
    end
  end

  context 'when we want pretty month_year url' do
    subject { build(:report, :date => DateTime.now.change(:month => 7, :year => 2009)) }

    it { should respond_to :month_year_path }
    its(:month_year_path) {should == '/reports/2009/7' }
  end
end
