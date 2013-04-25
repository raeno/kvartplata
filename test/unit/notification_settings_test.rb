require 'test_helper'

class NotificationSettingsTest < ActiveSupport::TestCase

  setup do
    @user = create(:user)
  end

  test 'user should have notification_settings' do
    assert_not_nil @user.notification_settings
  end
end
