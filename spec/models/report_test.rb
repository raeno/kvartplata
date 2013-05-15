require 'spec_helper'


describe Report do

  before(:each) do
    @simple_report = build(:report)
  end

  it 'compute_total should give sum of all counters values' do
    report = build(:report, cold_water: 10, hot_water: 20, utilities: 30, energy: 40)
    assert_in_epsilon 10+20+30+40, report.compute_total
  end

  it 'difference should return substraction of current and previous metrics' do
    report = build(:report_with_metrics)

    substraction = report.current_metric - report.previous_metric

    assert_in_epsilon substraction.hot_counter_kitchen, report.difference.hot_counter_kitchen
    assert_in_epsilon substraction.cold_counter_kitchen, report.difference.cold_counter_kitchen
    assert_in_epsilon substraction.hot_counter_bathroom, report.difference.hot_counter_bathroom
    assert_in_epsilon substraction.cold_counter_bathroom, report.difference.cold_counter_bathroom
  end

  it 'utilities_diff should return substraction of current and previous metrics utilities' do
    report = build(:report_with_metrics)
    utilities = report.current_metric.utilities - report.previous_metric.utilities
    assert_in_epsilon utilities, report.utilities_diff
  end

  it 'Report.from_metric should return new report generated based on this and previous metrics values' do

    Metric.delete_all

    previous_metric = create(:metric, month: 5.month.ago)
    source_metric = create(:metric, month: 4.month.ago)

    report = Report.from_metric source_metric

    report.should.not == nil
    report.tariff.should.not == nil

    report.current_metric.should == source_metric
    report.previous_metric.should == previous_metric
  end

  it 'grouped_by_month should correctly group reports by year and month' do
    (1..4).each do |month|
      create(:report, :date => DateTime.now.change(:day =>1, :month => month, :year => 2013) )
    end

    (1..6).each do |month|
      create(:report, :date => DateTime.now.change(:day => 1, :month => month, :year => 2012))
    end

    grouped_reports = Report.grouped_by_months

    grouped_reports.keys[0].should == 2013
    grouped_reports.keys[1].should == 2012
    grouped_reports.keys.count.should == 2

    grouped_reports[2013].count.should == 4
    grouped_reports[2012].count.should == 6
  end

  it 'month_year_path should return path to report in a year-month form' do
    report = build(:report, :date => DateTime.now.change(:month => 7, :year => 2009))
    report.month_year_path.should == '/reports/2009/7'
  end
end
