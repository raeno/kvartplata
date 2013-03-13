class Tariff < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :cold_water, :hot_water,
                  :energy, :utilities, :comments
  has_many :reports

  def self.used_in(month)
    Tariff.where('start_date <= :month AND end_date >= :month', month: month).last
  end
end
