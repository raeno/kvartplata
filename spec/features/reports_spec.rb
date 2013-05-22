require 'spec_helper'

describe 'Reports' do
  describe 'GET /reports' do

    context 'when user not authorized' do
      it 'redirects to authorization' do
        get reports_path
        response.status.should be(302)
      end
    end

    context 'when user authorized' do
      before  do
        sign_in_as_a_valid_user
        create(:tariff)
      end
      it 'show all reports' do
        get reports_path
        response.status.should be(200)
      end
    end
  end
end
