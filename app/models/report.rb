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
    previous_metric = metric.previous_month
    tariff = Tariff.that_was(metric.month)

    return if previous_metric.nil? or tariff.nil?

    report = Report.new(
        :current_metric => metric,
        :previous_metric => previous_metric,
        :tariff => tariff,
        :date => metric.month
    )

    report.fill_values
    report
  end

  def fill_values
    self.cold_water = difference.total_cold_water * tariff.cold_water
    self.hot_water = difference.total_hot_water * tariff.hot_water
    self.energy = difference.energy_counter * tariff.energy
    self.utilities = difference.utilities * tariff.utilities
    self.total = compute_total
  end


  def compute_total
    cold_water + hot_water + utilities + energy
  end

  def update_report!
    self.fill_values
    self.save
  end

  def self.grouped_by_months
    grouped_by_year = Report.all.group_by { |report| report.date.year}
    grouped_by_year.keys.each do |year|
      grouped_by_year[year] = grouped_by_year[year].group_by { |report| report.date.month }
    end
    grouped_by_year
  end

  def month_year_path
    Rails.application.routes.url_helpers.report_year_month_path(:year => date.year, :month => date.month)
  end
end
