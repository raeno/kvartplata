class Tariff < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :cold_water, :hot_water,
                  :energy, :utilities, :comments
end
