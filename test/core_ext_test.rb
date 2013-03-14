require 'test_helper'

class CoreExtTest < Test::Unit::TestCase

  def test_round_to_month_should_remain_only_month_and_year_in_datetime
    rounded_date = DateTime.now.round_to_month

    assert_equal DateTime.now.month, rounded_date.month
    assert_equal Time.now.year, rounded_date.year

    assert_equal 1, rounded_date.day
    assert_equal 0, rounded_date.hour
    assert_equal 0, rounded_date.min
    assert_equal 0, rounded_date.sec
  end

  def test_round_to_month_should_remain_only_month_and_year_for_TimeWithZone

    rounded_date = 1.month.ago.round_to_month

    assert_equal 1.month.ago.month, rounded_date.month
    assert_equal 1.month.ago.year, rounded_date.year

    assert_equal 1, rounded_date.day
    assert_equal 0, rounded_date.hour
    assert_equal 0, rounded_date.min
    assert_equal 0, rounded_date.sec
  end

end