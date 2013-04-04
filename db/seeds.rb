# encoding: UTF-8

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
ApartmentInfo.delete_all
User.delete_all

User.create(
    :email => 'admin@kvartplata.com',
    :password => 'password',
    :password_confirmation => 'password',
    :first_name => 'Василий',
    :last_name => 'Плюшкин'
)

ApartmentInfo.create(
    :owner => 'Плюшкин В.И',
    :number => 14,
    :address => 'Бугаева 82'
)

(2..10).each do |i|
  Tariff.create(
      :start_date => ((i+1)*3).month.ago,
      :end_date => (i*3).month.ago,
      :cold_water => 12.34 -i,
      :hot_water => 89.56 -i,
      :utilities => 6.94 - 0.3*i,
      :energy => 2.87 - 0.1*i
  )
end


Metric.create(
    :cold_counter_kitchen => 10,
    :hot_counter_kitchen => 8,
    :cold_counter_bathroom => 12,
    :hot_counter_bathroom => 11,
    :energy_counter => 110,
    :month =>  3.month.ago
)

Metric.create(
    :cold_counter_kitchen => 12,
    :hot_counter_kitchen => 10,
    :cold_counter_bathroom => 15,
    :hot_counter_bathroom => 13,
    :energy_counter => 150,
    :month =>  2.month.ago
)

Metric.create(
    :cold_counter_kitchen => 16,
    :hot_counter_kitchen => 12,
    :cold_counter_bathroom => 19,
    :hot_counter_bathroom => 15,
    :energy_counter => 210,
    :month =>  1.month.ago
)