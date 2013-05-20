FactoryGirl.define do

  factory :report do
    cold_water 62
    hot_water 78
    utilities 35
    energy 182
    total { cold_water + hot_water + utilities + energy }
    sequence(:date) { |n| (10-n).month.ago.round_to_month }

    factory :report_with_metrics do
      association :previous_metric, factory: :metric
      association :current_metric, factory: :metric
    end
    tariff
  end

end