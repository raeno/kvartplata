class Report < ActiveRecord::Base
  attr_accessible :cold_water, :date, :energy, :hot_water, :total, :utilities,
                  :current_metric,:previous_metric ,:tariff
  belongs_to :current_metric, class_name: 'Metric'
  belongs_to :previous_metric, class_name: 'Metric'
  belongs_to :tariff

  def difference
    current_metric - previous_metric
  end

  def utilities_diff
    current_metric.utilities - previous_metric.utilities
  end
end
