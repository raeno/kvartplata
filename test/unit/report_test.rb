require 'test_helper'

class ReportTest < ActiveSupport::TestCase

  setup do
    @simple_report = build(:report)
  end

  test 'compute_total should give sum of all counters values' do
    report = build(:report, cold_water: 10, hot_water: 20, utilities: 30, energy: 40)
    assert_in_epsilon 10+20+30+40, report.compute_total
  end

  test 'difference should return substraction of current and previous metrics' do
    report = build(:report_with_metrics)

    substraction = report.current_metric - report.previous_metric

    assert_in_epsilon substraction.hot_counter_kitchen, report.difference.hot_counter_kitchen
    assert_in_epsilon substraction.cold_counter_kitchen, report.difference.cold_counter_kitchen
    assert_in_epsilon substraction.hot_counter_bathroom, report.difference.hot_counter_bathroom
    assert_in_epsilon substraction.cold_counter_bathroom, report.difference.cold_counter_bathroom
  end

  test 'utilities_diff should return substraction of current and previous metrics utilities' do
    report = build(:report_with_metrics)
    utilities = report.current_metric.utilities - report.previous_metric.utilities
    assert_in_epsilon utilities, report.utilities_diff
  end

  test 'Report.from_metric should return new report generated based on this and previous metrics values' do

    Metric.delete_all

    previous_metric = create(:metric, month: 5.month.ago)
    source_metric = create(:metric, month: 4.month.ago)

    report = Report.from_metric source_metric

    assert_not_nil report
    assert_not_nil report.tariff

    assert_equal source_metric, report.current_metric
    assert_equal previous_metric, report.previous_metric

  end





end
