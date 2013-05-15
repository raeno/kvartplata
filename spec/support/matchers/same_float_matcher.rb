require 'rspec/expectations'

RSpec::Matchers.define :be_same_float_as do |expected|
  match do |actual|
    actual.should be_within(0.0001).of expected
  end
end