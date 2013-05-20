
module ControllerHelpers
  def signed_in_as_a_valid_user(user = double('env'))
    if user.nil?
      request.env['warden'].stub(:authenticate!).and_throw(:warder, { :scope => :user})
      controller.stub :current_user => nil
    else
      request.env['warden'].stub :authenticate! => user
      controller.stub :current_user => user
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerHelpers, :type => :controller
end