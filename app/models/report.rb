class Report < ActiveRecord::Base
  attr_accessible :cold_water, :date, :energy, :hot_water, :total, :utilities,
                  :current_metric_id,:previous_metric_id ,:tariff_id
  belongs_to :current_metric, class_name: 'Metric'
  belongs_to :previous_metric, class_name: 'Metric'
  belongs_to :tariff
end
