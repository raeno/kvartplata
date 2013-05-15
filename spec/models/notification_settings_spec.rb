require 'spec_helper'

describe NotificationSettings do

  before(:all) do
    @user = create(:user)
  end

  it 'user should have notification_settings' do
    @user.notification_settings.should.not == nil
  end
end
