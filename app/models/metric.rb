require "previous_record_value_validator"

class Metric < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :cold_counter_kitchen, :cold_counter_bathroom, :hot_counter_kitchen, :hot_counter_bathroom,
                  :energy_counter, :month

  validates_presence_of :cold_counter_kitchen, :cold_counter_bathroom,
                        :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter

  validates_that_greater_than_a_previous_value :cold_counter_kitchen, :cold_counter_bathroom,
                 :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter

  has_many :reports




  def previous_record
    @previous ||= Metric.where('month < ?',month).last
  end

  def -(value)
     Metric.new(
        :hot_counter_bathroom => self.hot_counter_bathroom - value.hot_counter_bathroom,
        :hot_counter_kitchen => self.hot_counter_kitchen - value.hot_counter_kitchen,
        :cold_counter_bathroom => self.cold_counter_bathroom - value.cold_counter_bathroom,
        :cold_counter_kitchen => self.cold_counter_kitchen - value.cold_counter_kitchen,
        :energy_counter => self.energy_counter - value.energy_counter,

    )
  end

  def utilities
    self.hot_counter_bathroom + self.hot_counter_kitchen + self.cold_counter_bathroom + self.cold_counter_kitchen
  end


end
