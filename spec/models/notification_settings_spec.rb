require 'spec_helper'

describe NotificationSettings do

  let(:user) { create :user }

  it 'available as user method' do
    user.notification_settings.should_not be_nil
  end
end
