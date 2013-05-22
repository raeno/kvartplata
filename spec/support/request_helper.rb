# module for helping request specs
module ValidUserRequestHelper
  # for use in request specs
  def sign_in_as_a_valid_user
    @user ||= FactoryGirl.create :user
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
  end
end

module ValidUserFeatureHelper
  # for use in request specs
  def sign_in_as_a_valid_user
    user = create :user
    login_as(user)
  end
end

RSpec.configure do |config|
  config.include ValidUserRequestHelper, :type => :request
  config.include ValidUserFeatureHelper, :type => :feature
end