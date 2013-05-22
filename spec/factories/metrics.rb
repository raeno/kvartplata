FactoryGirl.define do


  factory :metric do

    sequence(:cold_counter_kitchen) { |n| 24 + 3*n }
    sequence(:hot_counter_kitchen) { |n| 11 + 2*n }
    sequence(:cold_counter_bathroom) { |n| 32 + 4.2*n }
    sequence(:hot_counter_bathroom) { |n| 15 + 2.4*n }
    sequence(:energy_counter) { |n| 621 + 123*n }
    sequence(:month) { |n| (50-n).month.ago.round_to_month }
  end

  factory :metric_with_report, class: Metric do
    sequence(:cold_counter_kitchen) { |n| 24 + 3*n }
    sequence(:hot_counter_kitchen) { |n| 11 + 2*n }
    sequence(:cold_counter_bathroom) { |n| 32 + 4.2*n }
    sequence(:hot_counter_bathroom) { |n| 15 + 2.4*n }
    sequence(:energy_counter) { |n| 621 + 123*n }
    sequence(:month) { |n| (50-n).month.ago.round_to_month }
    report
  end

  factory :metric_with_counters_10, class: Metric do
    cold_counter_bathroom 10
    cold_counter_kitchen  10
    hot_counter_bathroom 10
    hot_counter_kitchen 10
    energy_counter 10
    month 10.month.ago
  end

  factory :metric_with_counters_20, class: Metric do
    cold_counter_bathroom 20
    cold_counter_kitchen  20
    hot_counter_bathroom 20
    hot_counter_kitchen 20
    energy_counter 20
    month 9.month.ago
  end

end