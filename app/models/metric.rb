class Metric < ActiveRecord::Base
  attr_accessible :cold_counter_kitchen, :cold_counter_bathroom, :hot_counter_kitchen, :hot_counter_bathroom,
                  :energy_counter, :month
  validates_presence_of :cold_counter_kitchen, :cold_counter_bathroom,
                        :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter

  #validates_numericality_of :cold_counter_kitchen, :greater_than => Proc.new { |r| r.previous_metric.cold_counter_kitchen }, :allow_blank => true
  validates_each :cold_counter_kitchen, :cold_counter_bathroom,
                 :hot_counter_kitchen, :hot_counter_bathroom, :energy_counter do |record,attr,value|
    record.errors.add(attr, "must be greater than #{record.previous_metric.send(attr)}") if value <= record.previous_metric.send(attr)
  end


  def previous_metric
    @previous ||= Metric.where('month < ?',month).last
  end


end
