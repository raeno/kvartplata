require 'chronic'
class Tariff < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :cold_water, :hot_water,
                  :energy, :utilities, :comments
  has_many :reports

  validates_presence_of :start_date, :cold_water, :hot_water, :energy, :utilities

  validates :cold_water, :hot_water, :energy, :utilities, numericality: {greater_than: 0.01}

  def previous
    Tariff.where('end_date < ?',start_date).last(:order => 'end_date') if Tariff.all.size > 1
  end

  def after_initialize
    @attributes['start_date'] = Chronic.parse(@attributes[:start_date]) unless @attributes[:start_date].blank?
    @attributes['end_date'] = Chronic.parse(@attributes[:end_date]) unless @attributes[:end_date].blank?
  end

  class << self

    def is_there_more_than_two?
      Tariff.all.size > 2
    end

    def that_was(month)
      Tariff.where('start_date <= :month AND end_date >= :month', month: month).last
    end
  end
end
