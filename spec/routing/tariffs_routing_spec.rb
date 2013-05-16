require "spec_helper"

describe TariffsController do
  describe "routing" do

    it "routes to #index" do
      get("/tariffs").should route_to("tariffs#index")
    end

    it "routes to #new" do
      get("/tariffs/new").should route_to("tariffs#new")
    end

    it "routes to #show" do
      get("/tariffs/1").should route_to("tariffs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tariffs/1/edit").should route_to("tariffs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tariffs").should route_to("tariffs#create")
    end

    it "routes to #update" do
      put("/tariffs/1").should route_to("tariffs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tariffs/1").should route_to("tariffs#destroy", :id => "1")
    end

  end
end
