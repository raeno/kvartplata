# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_settings, :class => 'NotificationSettings' do
    enabled false
    notify_by_email false
    notify_by_phone false
    day 20
    hour 18
    minute 0
  end
end
