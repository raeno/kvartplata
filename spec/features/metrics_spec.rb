require 'spec_helper'

describe 'Metrics' do

  describe 'GET #new' do

    before do
      sign_in_as_a_valid_user
      create :tariff
      create :metric, :month => DateTime.new(2013,5,1).round_to_month
      Capybara.ignore_hidden_elements = false
    end

    after { Capybara.ignore_hidden_elements = true}

    it 'stores already filled months in a hidden div' do
      visit new_metric_path
      data = page.find '#metrics_with_data'
      data['data-metrics'].should == '["05/2013"]'
    end
  end
end
