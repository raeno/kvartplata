require 'test_helper'

class MetricTest < ActiveSupport::TestCase

  setup do
    @simple_metric = build(:metric)
  end

  teardown do
    Timecop.return
    Metric.delete_all
  end

  test 'utilities should be the sum of all water counters' do
    all_water_counters_sum = @simple_metric.cold_counter_kitchen + @simple_metric.hot_counter_kitchen +
                              @simple_metric.cold_counter_bathroom + @simple_metric.hot_counter_bathroom

    assert_in_epsilon all_water_counters_sum, @simple_metric.utilities
  end

  test 'total_cold_water should return sum of all cold counters' do
    assert_in_epsilon @simple_metric.cold_counter_kitchen + @simple_metric.cold_counter_bathroom, @simple_metric.total_cold_water
  end

  test 'total_hot_water should return sum of all hot counters' do
    assert_in_epsilon @simple_metric.hot_counter_kitchen + @simple_metric.hot_counter_bathroom, @simple_metric.total_hot_water
  end

  test 'all counter should be positive numbers' do
    counters = @simple_metric.attributes.keys.find_all { |method| /^((?:cold|hot|energy)_counter.*)$/ =~ method }

    counters.each do |counter|
      method = counter + '='


      @simple_metric.send(method,-1)
      assert @simple_metric.invalid?
      assert @simple_metric.errors.error_names[counter.to_sym].include? :greater_than

      @simple_metric.send(method,0)
      assert @simple_metric.invalid?
      assert @simple_metric.errors.error_names[counter.to_sym].include? :greater_than

      @simple_metric.send(method,3)
      assert @simple_metric.valid?
    end
  end

  test 'difference of two metrics should be difference of counters' do

    first_metric = build(:metric,cold_counter_kitchen: 10, hot_counter_kitchen: 10,
                         cold_counter_bathroom: 10, hot_counter_bathroom: 10,
                         energy_counter: 100)

    second_metric = build(:metric, cold_counter_kitchen: 20,  hot_counter_kitchen: 30,
                          cold_counter_bathroom: 40, hot_counter_bathroom: 50,
                          energy_counter: 200)


    difference = second_metric - first_metric

    assert_in_epsilon 10, difference.cold_counter_kitchen
    assert_in_epsilon 20, difference.hot_counter_kitchen
    assert_in_epsilon 30, difference.cold_counter_bathroom
    assert_in_epsilon 40, difference.hot_counter_bathroom

    assert_in_epsilon 100, difference.energy_counter

  end

  test 'previous metric should be from previous month' do

    Metric.delete_all

    metrics = []

    metrics << create(:metric, month: 3.month.ago)
    metrics << create(:metric, month: 2.month.ago)
    metrics << create(:metric, month: 1.month.ago)


    prev = metrics[1].previous_record

    assert_equal metrics[0], prev
  end

  test 'we do not need to pay if we already made payment' do
    metric = create(:metric)

    payment_day = metric.month.change(:day => Metric::PAYMENT_DAY)
    Timecop.freeze payment_day-10.day
    assert (not Metric.time_to_pay?)

    Timecop.freeze payment_day
    assert (not Metric.time_to_pay?)

    Timecop.freeze payment_day+5.day
    assert (not Metric.time_to_pay?)
  end


  test 'we do not need to pay if payment day is not near' do
    Timecop.freeze(Time.now.change(:day => Metric::PAYMENT_DAY - 10))
    assert (not Metric.time_to_pay?)
  end

  test 'we need to pay if payment day is near' do
    Timecop.freeze(Time.now.change(:day => Metric::PAYMENT_DAY - 1))
    assert  Metric.time_to_pay?
  end



end
