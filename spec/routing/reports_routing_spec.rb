require 'spec_helper'

describe ReportsController do
  describe 'routing' do

    it 'routes to #index' do
      get('/reports').should route_to('reports#index')
    end

    it 'routes to #show' do
      get('/reports/2013/2').should route_to('reports#show', month: '2', year: '2013' )
    end

    it "routes to #edit" do
      get("/reports/1/edit").should_not route_to("reports#edit", :id => "1")
    end

    it "routes to #update" do
      put("/reports/1").should_not route_to("reports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reports/1").should_not route_to("reports#destroy", :id => "1")
    end

  end
end
