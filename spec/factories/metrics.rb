FactoryGirl.define do
  factory :metric do
    sequence(:cold_counter_kitchen) { |n| 24 + 3*n }
    sequence(:hot_counter_kitchen) { |n| 11 + 2*n }
    sequence(:cold_counter_bathroom) { |n| 32 + 4.2*n }
    sequence(:hot_counter_bathroom) { |n| 15 + 2.4*n }
    sequence(:energy_counter) { |n| 621 + 123*n }
    sequence(:month) { |n| (10-n).month.ago.round_to_month }

    report

  end
end