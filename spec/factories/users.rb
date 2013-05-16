# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@kvartplata.com" }
    password 'password'
    password_confirmation 'password'
    first_name 'Admin'
    last_name 'Beard'

    notification_settings
  end
end
