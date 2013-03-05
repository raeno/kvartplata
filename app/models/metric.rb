class Metric < ActiveRecord::Base
  attr_accessible :cold_counter_kitchen, :cold_counter_bathroom, :hot_counter_kitchen, :hot_counter_bathroom,
                  :energy_counter
end
