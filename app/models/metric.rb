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

  def after_initialize
    @attributes['month'] = Chronic.parse(@attributes[:month]) unless @attributes[:month].blank?
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

  def create_report
    report = Report.from_metric(self)
    report.save unless report.nil?
    self.report = report
  end

  def ==(another_metric)

    (self.hot_counter_kitchen.in_delta_with hot_counter_kitchen) &&
    (self.hot_counter_bathroom.in_delta_with hot_counter_bathroom) &&
    (self.cold_counter_bathroom.in_delta_with cold_counter_bathroom) &&
    (self.hot_counter_bathroom.in_delta_with hot_counter_bathroom) &&
    (self.energy_counter.in_delta_with energy_counter) &&
    (self.month == another_metric.month)
  end

  class << self

    def time_to_pay?
      metric = Metric.where('month = ?', DateTime.now.round_to_month).last
      if metric.nil?
        return Metric.near_payment_day?
      end
      false
    end

    def near_payment_day?
      3.days.since.day >= PAYMENT_DAY
    end

    def has_data
      @has_data ||= Metric.all.map { |metric| metric.month.strftime('%m/%Y') }
    end
  end
end
