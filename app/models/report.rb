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

  def self.from_metric(metric)
    previous_metric = Metric.where('month < ?', metric.month).last
    tariff = Tariff.used_in(metric.month)

    return if previous_metric.nil? or tariff.nil?

    report = Report.new(
        :current_metric => metric,
        :previous_metric => previous_metric,
        :tariff => tariff,
        :date => metric.month
    )

    difference = report.difference

    report.cold_water = difference.total_cold_water * tariff.cold_water
    report.hot_water = difference.total_hot_water * tariff.hot_water
    report.energy = difference.energy_counter * tariff.energy
    report.utilities = difference.utilities * tariff.utilities
    report.total = report.compute_total
    report
  end

  def compute_total
    cold_water + hot_water + utilities + energy
  end
end
