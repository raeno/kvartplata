# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Metric.delete_all
Tariff.delete_all
Report.delete_all

old_metric = Metric.create(
    :cold_counter_kitchen => 10,
    :hot_counter_kitchen => 8,
    :cold_counter_bathroom => 12,
    :hot_counter_bathroom => 11,
    :energy_counter => 110,
    :month =>  3.month.ago
)

prev_metric = Metric.create(
    :cold_counter_kitchen => 12,
    :hot_counter_kitchen => 10,
    :cold_counter_bathroom => 15,
    :hot_counter_bathroom => 13,
    :energy_counter => 150,
    :month =>  2.month.ago
)

current_metric = Metric.create(
    :cold_counter_kitchen => 16,
    :hot_counter_kitchen => 12,
    :cold_counter_bathroom => 19,
    :hot_counter_bathroom => 15,
    :energy_counter => 210,
    :month =>  1.month.ago
)

current_tariff = Tariff.create(
    :start_date => 5.month.ago,
    :cold_water => 12.74,
    :hot_water => 90.86,
    :utilities => 7.64,
    :energy => 3.23
)

Report.create(
    :date => DateTime.now,
    :cold_water => 30,
    :hot_water => 40,
    :utilities => 20,
    :energy => 50,
    :total => 140,
    :current_metric => current_metric,
    :previous_metric => prev_metric,
    :tariff => current_tariff
)





