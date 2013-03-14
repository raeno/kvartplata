require "previous_record_value_validator"

class Metric < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :cold_counter_kitchen, :cold_counter_bathroom, :hot_counter_kitchen, :hot_counter_bathroom,
                  :energy_counter, :month

  validates_presence_of :cold_counter_kitchen, :cold_counter_bathroom,
                        :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter

  validates :cold_counter_kitchen, :cold_counter_bathroom, :hot_counter_kitchen,
            :hot_counter_bathroom, :energy_counter, :numericality => { greater_than: 0.001}

  validates_that_greater_than_a_previous_value :cold_counter_kitchen, :cold_counter_bathroom,
                 :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter

  has_many :reports, :foreign_key => 'current_metric_id'

  attr_accessor :report

  before_validation :round_month

  after_save :create_report

  PAYMENT_DAY = 20


  def previous_record
    @previous ||= Metric.where('month < ?',month).last
  end

  def -(value)
     Metric.new(
        :hot_counter_bathroom => hot_counter_bathroom - value.hot_counter_bathroom,
        :hot_counter_kitchen => hot_counter_kitchen - value.hot_counter_kitchen,
        :cold_counter_bathroom => cold_counter_bathroom - value.cold_counter_bathroom,
        :cold_counter_kitchen => cold_counter_kitchen - value.cold_counter_kitchen,
        :energy_counter => energy_counter - value.energy_counter
    )
  end

  def utilities
    hot_counter_bathroom + hot_counter_kitchen + cold_counter_bathroom + cold_counter_kitchen
  end

  def total_cold_water
    cold_counter_bathroom + cold_counter_kitchen
  end

  def total_hot_water
    hot_counter_bathroom + hot_counter_kitchen
  end

  def round_month
    self.month = month.round_to_month
  end

  def self.time_to_pay?
    metric = Metric.where('month = ?', DateTime.now.round_to_month).last
    if metric.nil?
      return Metric.near_payment_day?
    end
    false
  end

  def self.near_payment_day?
    3.days.since.day >= PAYMENT_DAY
  end

  def create_report
    report = Report.from_metric(self)
    report.save unless report.nil?
    self.report = report
  end

end
