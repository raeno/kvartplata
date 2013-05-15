require 'spec_helper'

describe Tariff do

  context 'when we want tariff that was active for a particular month' do
    before do
      @very_old_tariff = create(:tariff, start_date: 20.month.ago, end_date: 10.month.ago)
      @old_tariff = create(:tariff, start_date: 9.month.ago, end_date: 3.month.ago)
      @current_tariff = create(:tariff, start_date: 3.month.ago + 1.day)
    end

    context 'and we far in the past' do
      specify { Tariff.that_was(10.years.ago).should be_nil }
      specify { Tariff.that_was(12.month.ago).should == @very_old_tariff }
    end

    context 'and we not so far in the past' do
      specify { Tariff.that_was(6.month.ago).should == @old_tariff }
      specify { Tariff.that_was(3.month.ago - 2.day).should == @old_tariff }
    end

    context 'and we near present day or in future' do
      specify { Tariff.that_was(1.day.ago).should == @current_tariff }
      specify { Tariff.that_was(DateTime.now).should == @current_tariff }
      specify { Tariff.that_was(2.year.since).should == @current_tariff }
    end
  end

  context 'when we check is there more than two tariffs' do

    describe 'with zero tariffs' do
      specify { Tariff.is_there_more_than_two?.should be_false }
    end

    describe 'with one tariff' do
      before { create(:tariff) }
      specify { Tariff.is_there_more_than_two?.should be_false }
    end

    describe 'with two tariffs' do
      before { 2.times { create(:tariff) } }
      specify { Tariff.is_there_more_than_two?.should be_false }
    end

    describe 'with more than two tariffs' do
      before { 3.times { create(:tariff) } }
      specify { Tariff.is_there_more_than_two?.should be_true }
    end
  end
end
