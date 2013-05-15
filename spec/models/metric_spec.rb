require 'spec_helper'

describe Metric do
  let(:simple_metric) { build(:metric) }


  after(:each) do
    Timecop.return
    Metric.delete_all
  end

  it 'utilities should be the sum of all water counters' do
    all_water_counters_sum = simple_metric.cold_counter_kitchen + simple_metric.hot_counter_kitchen +
                              simple_metric.cold_counter_bathroom + simple_metric.hot_counter_bathroom

    all_water_counters_sum.should be_within(0.01).of simple_metric.utilities
  end

  it 'total_cold_water should return sum of all cold counters' do
    (simple_metric.cold_counter_kitchen + simple_metric.cold_counter_bathroom).should be_within(0.01).of simple_metric.total_cold_water
  end

  it 'total_hot_water should return sum of all hot counters' do
    (simple_metric.hot_counter_kitchen + simple_metric.hot_counter_bathroom).should be_within(0.01).of simple_metric.total_hot_water
  end

  it 'all counters are positive numbers' do
    counters = simple_metric.attributes.keys.find_all { |method| /^((?:cold|hot|energy)_counter.*)$/ =~ method }

    counters.each do |counter|
      method = counter + '='

      simple_metric.send(method,-1)
      simple_metric.invalid?.should be_true
      simple_metric.errors.error_names[counter.to_sym].should include :greater_than

      simple_metric.send(method,0)
      simple_metric.invalid?.should be_true
      simple_metric.errors.error_names[counter.to_sym].should include :greater_than

      simple_metric.send(method,3)
      simple_metric.valid?.should be_true
    end
  end

  it 'difference with another metric is difference of its counters' do

    first_metric = build(:metric,cold_counter_kitchen: 10, hot_counter_kitchen: 10,
                         cold_counter_bathroom: 10, hot_counter_bathroom: 10,
                         energy_counter: 100)

    second_metric = build(:metric, cold_counter_kitchen: 20,  hot_counter_kitchen: 30,
                          cold_counter_bathroom: 40, hot_counter_bathroom: 50,
                          energy_counter: 200)


    difference = second_metric - first_metric

    difference.cold_counter_kitchen.should be_within(0.01).of 10
    difference.hot_counter_kitchen.should be_within(0.01).of 20
    difference.cold_counter_bathroom.should be_within(0.01).of 30
    difference.hot_counter_bathroom.should be_within(0.01).of 40

    difference.energy_counter.should be_within(0.01).of 100

  end

  # TODO: should be extended, bad test case
  it 'returns previous_record as Metric of previous_month' do
    Metric.delete_all

    metrics = []

    metrics << create(:metric, month: 3.month.ago)
    metrics << create(:metric, month: 2.month.ago)
    metrics << create(:metric, month: 1.month.ago)

    prev = metrics[1].previous_record

    prev.should == metrics[0]
  end

  it 'should not be payed twice' do
    metric = create(:metric)

    payment_day = metric.month.change(:day => Metric::PAYMENT_DAY)
    Timecop.freeze payment_day-10.day
    Metric.time_to_pay?.should be_false

    Timecop.freeze payment_day
    Metric.time_to_pay?.should be_false

    Timecop.freeze payment_day+5.day
    Metric.time_to_pay?.should be_false
  end


  it 'does not ask to pay if there many time before payment date' do
    Timecop.freeze(Time.now.change(:day => Metric::PAYMENT_DAY - 10))
    Metric.time_to_pay?.should be_false
  end

  it 'ask to pay payment day is near' do
    Timecop.freeze(Time.now.change(:day => Metric::PAYMENT_DAY - 1))
    Metric.time_to_pay?.should be_true
  end



end
