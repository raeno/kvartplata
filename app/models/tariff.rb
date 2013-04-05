class Tariff < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :cold_water, :hot_water,
                  :energy, :utilities, :comments
  has_many :reports

  validates :cold_water, :hot_water, :energy, :utilities, numericality: {greater_than: 0.01}

  def previous
    Tariff.where('end_date < ?',start_date).last(:order => 'end_date') if Tariff.all.size > 1
  end

  class << self

    def is_there_more?
      Tariff.all.size > 2
    end

    def that_was(month)
      Tariff.where('start_date <= :month AND end_date >= :month', month: month).last
    end
  end
end
