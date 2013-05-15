require 'spec_helper'

describe Tariff do

  it 'Tariff.that_was should return tariff that was active for the specified month' do

    very_old_tariff = create(:tariff, start_date: 20.month.ago, end_date: 10.month.ago)

    old_tariff = create(:tariff, start_date: 9.month.ago, end_date: 3.month.ago)

    current_tariff = create(:tariff, start_date: 3.month.ago + 1.day)

    Tariff.that_was(10.years.ago).should == nil

    Tariff.that_was(12.month.ago).should == very_old_tariff

    Tariff.that_was(6.month.ago).should == old_tariff
    Tariff.that_was(3.month.ago - 2.day).should == old_tariff

    Tariff.that_was(1.day.ago).should == current_tariff
    Tariff.that_was(DateTime.now).should == current_tariff
    Tariff.that_was(2.year.since).should == current_tariff
  end

  it 'is_there_more_than_two? should return true if there more than two tariffs' do

    Tariff.is_there_more_than_two?.should == false

    create(:tariff)
    Tariff.is_there_more_than_two?.should == false

    create(:tariff)
    Tariff.is_there_more_than_two?.should == false

    create(:tariff)
    Tariff.is_there_more_than_two?.should == true
  end


end
