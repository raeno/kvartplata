require 'spec_helper'

describe CoreExt do

  it 'round to month should remain only month and year in datetime' do
    rounded_date = DateTime.now.round_to_month

    rounded_date.month.should == DateTime.now.month
    rounded_date.year.should == Time.now.year

    rounded_date.day.should == 1
    rounded_date.hour.should == 0
    rounded_date.min.should == 0
    rounded_date.sec.should == 0
  end

  it 'round to month should remain only month and year for TimeWithZone' do

    rounded_date = 1.month.ago.round_to_month

    rounded_date.month.should == 1.month.ago.month
    rounded_date.year.should == 1.month.ago.year

    rounded_date.day.should == 1
    rounded_date.hour.should == 0
    rounded_date.min.should == 0
    rounded_date.sec.should == 0
  end

end