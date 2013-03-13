require 'test_helper'

class MetricTest < ActiveSupport::TestCase

  setup do
    @simple_metric = build(:metric)
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
      assert_equal 'must be greater than 0.001', @simple_metric.errors[counter].join('; ')

      @simple_metric.send(method,0)
      assert @simple_metric.invalid?
      assert_equal 'must be greater than 0.001', @simple_metric.errors[counter].join('; ')

      @simple_metric.send(method,3)
      assert @simple_metric.valid?

    end
  end



end
