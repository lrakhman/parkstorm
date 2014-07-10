require 'rails_helper'

RSpec.describe RegionsController, :type => :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET date_range" do
    it "assigns @today" do
      get :date_range
      expect(assigns(:today)).to eq(Date.today)
    end

    it "renders the date_range template" do
      get :date_range
      expect(response).to render_template("date_range")
    end
  end

  describe "post current_position" do
    it "responds to a post" do
      post :current_position, {latitude: 50, longitude: 50}
      expect(response).to be_ok
    end
  end

  describe "post load_region" do
    it 'renders the map partial' do
      post :load_region, {latitude: 50, longitude: 50}
      expect(response).to render_template("_map")
    end
  end

  describe "post load_region_from_address" do
    it 'renders the address_map partial' do
      post :load_region_from_address, {latitude: 50, longitude: 50}
      expect(response).to render_template("_address_map")
    end
  end

    describe "post load_region_after_date_change" do
    it 'renders the map partial' do
      post :load_after_date_change, {latitude: 50, longitude: 50, date: ["2014-07-01", "2014-07-02"]}
      expect(response).to render_template("_map")
    end
  end
end
