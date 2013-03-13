FactoryGirl.define do
  factory :metric do
    sequence(:cold_counter_kitchen) { |n| 24 + 3*n }
    sequence(:hot_counter_kitchen) { |n| 11 + 2*n }
    sequence(:cold_counter_bathroom) { |n| 32 + 4.2*n }
    sequence(:hot_counter_bathroom) { |n| 15 + 2.4*n }
    sequence(:energy_counter) { |n| 621 + 123*n }
    sequence(:month) { |n| (10-n).month.ago }
  end
  
  factory :tariff do
    start_date 5.month.ago
    end_date 1000.years.since
    cold_water  12.74
    hot_water  90.86
    utilities  7.64
    energy  3.23
  end
end