require "previous_record_value_validator"

class Metric < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :cold_counter_kitchen, :cold_counter_bathroom, :hot_counter_kitchen, :hot_counter_bathroom,
                  :energy_counter, :month
  validates_presence_of :cold_counter_kitchen, :cold_counter_bathroom,
                        :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter

  validates_that_greater_than_a_previous_value :cold_counter_kitchen, :cold_counter_bathroom,
                 :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter




  def previous_record
    @previous ||= Metric.where('month < ?',month).last
  end


end
