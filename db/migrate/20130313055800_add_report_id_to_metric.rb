class AddReportIdToMetric < ActiveRecord::Migration
  def change
    add_column :metrics, :report_id, :integer, :references => 'reports'
  end
end
