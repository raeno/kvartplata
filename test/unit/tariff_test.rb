require 'test_helper'

class TariffTest < ActiveSupport::TestCase

  test 'Tariff.that_was should return tariff that was active for the specified month' do

    very_old_tariff = create(:tariff, start_date: 20.month.ago, end_date: 10.month.ago)

    old_tariff = create(:tariff, start_date: 9.month.ago, end_date: 3.month.ago)

    current_tariff = create(:tariff, start_date: 3.month.ago + 1.day)

    assert_nil Tariff.that_was(10.years.ago)

    assert_equal very_old_tariff, Tariff.that_was(12.month.ago)

    assert_equal old_tariff, Tariff.that_was(6.month.ago)
    assert_equal old_tariff, Tariff.that_was(3.month.ago - 2.day)

    assert_equal current_tariff, Tariff.that_was(1.day.ago)
    assert_equal current_tariff, Tariff.that_was(DateTime.now)
    assert_equal current_tariff, Tariff.that_was(2.year.since)
  end

  test 'is_there_more_than_two? should return true if there more than two tariffs' do

    assert_false Tariff.is_there_more_than_two?

    create(:tariff)
    assert_false Tariff.is_there_more_than_two?

    create(:tariff)
    assert_false Tariff.is_there_more_than_two?

    create(:tariff)
    assert_true Tariff.is_there_more_than_two?
  end


end
