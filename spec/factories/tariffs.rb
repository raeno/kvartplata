FactoryGirl.define do

  factory :tariff do
    start_date 100.years.ago
    end_date 1000.years.since
    cold_water  12.74
    hot_water  90.86
    utilities  7.64
    energy  3.23
  end

end
