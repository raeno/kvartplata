require 'spec_helper'

describe Metric do
  let(:simple_metric) { build :metric }


  after(:each) do
    Timecop.return
    Metric.delete_all
  end

  describe '#utilities' do
    it 'is sum of all water counters' do
      all_water_counters_sum = simple_metric.cold_counter_kitchen + simple_metric.hot_counter_kitchen +
          simple_metric.cold_counter_bathroom + simple_metric.hot_counter_bathroom

      all_water_counters_sum.should be_same_float_as simple_metric.utilities
    end
  end

  describe '#total_cold_water' do
    it 'is sum of all cold counters' do
      sum = simple_metric.cold_counter_kitchen + simple_metric.cold_counter_bathroom
      sum.should be_same_float_as simple_metric.total_cold_water
    end
  end

  describe '#total_hot_water' do
    it 'is sum of all hot counters' do
      sum = simple_metric.hot_counter_kitchen + simple_metric.hot_counter_bathroom
      sum.should be_same_float_as simple_metric.total_hot_water
    end
  end

  describe 'it validates that all counters are positive numbers' do
    subject { build :metric }

    it { should accept_values_for :cold_counter_kitchen, 10 }
    it { should_not accept_values_for :cold_counter_kitchen, -10, -1, 0 }

    it { should accept_values_for :hot_counter_kitchen, 10 }
    it { should_not accept_values_for :hot_counter_kitchen, -10, -1, 0 }

    it { should accept_values_for :cold_counter_bathroom, 10}
    it { should_not accept_values_for :cold_counter_bathroom, -10, -1, 0 }

    it { should accept_values_for :cold_counter_kitchen, 10 }
    it { should_not accept_values_for :cold_counter_kitchen, -10, -1, 0 }

    it { should accept_values_for :energy_counter, 10}
    it { should_not accept_values_for :energy_counter, -10, -1, 0 }
  end

  context 'when substracting one metric from another' do

    let(:first_metric) { build :metric_with_counters_10 }
    let(:second_metric) { build :metric_with_counters_20 }

    describe 'result counters are a differences of this metrics counter' do

      subject { second_metric - first_metric }

      its(:cold_counter_kitchen) { should be_same_float_as 10 }
      its(:hot_counter_kitchen) { should be_same_float_as 10 }
      its(:cold_counter_bathroom) { should be_same_float_as 10 }
      its(:hot_counter_bathroom) { should be_same_float_as 10 }
      its(:energy_counter) { should be_same_float_as 10 }
    end
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

  context 'when we already paid' do
    before do
      metric = create :metric
      @payment_day = metric.month.change(:day => Metric::PAYMENT_DAY)
    end

    context 'when payment date is far in future' do
      before { Timecop.freeze @payment_day-10.day}

      it 'does not ask to pay' do
        Metric.time_to_pay?.should be_false
      end
    end

    context 'when payment date is tomorrow' do
      before { Timecop.freeze @payment_day-1.day}

      it 'does not ask to pay' do
        Metric.time_to_pay?.should be_false
      end
    end

    context 'when payment date was few days ago' do
      before { Timecop.freeze @payment_day+5.day}

      it 'does not ask to pay' do
        Metric.time_to_pay?.should be_false
      end
    end
  end

  context 'when we had not paid yet' do
    context 'when payment day is near' do
      before { Timecop.freeze(Time.now.change(:day => Metric::PAYMENT_DAY - 1)) }

      it 'ask to pay' do
        Metric.time_to_pay?.should be_true
      end
    end

    context 'when there is many time before payment date' do
      before { Timecop.freeze(Time.now.change(:day => Metric::PAYMENT_DAY - 10)) }

      it 'does not ask to pay' do
        Metric.time_to_pay?.should be_false
      end
    end
  end
end

