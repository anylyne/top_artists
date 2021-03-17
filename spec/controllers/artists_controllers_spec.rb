require "rails_helper"

RSpec.describe ArtistsController, type: :controller do
  describe "GET show artist" do
    it "returns a 200" do
      get :show, params: { name: 'Rihanna' }
      expect(response).to have_http_status(:ok)
      expect(assigns(:tracks).size).to eq(5)
      expect(assigns(:summary)).to eq({ "artist"=>"Rihanna", 
                                           "page"=>"1", 
                                           "perPage"=>"5", 
                                           "total"=>"190748", 
                                           "totalPages"=>"38150"})
    end
  end
  describe "GET index" do
    it "returns a 200" do
      get :index, params: {country: 'Brazil'}
      expect(response).to have_http_status(:ok)
      expect(assigns(:artists).size).to eq(5) 
      expect(assigns(:summary)).to eq( "country"=>"Brazil", 
                                          "page"=>"1", 
                                          "perPage"=>"5", 
                                          "total"=>"1167222", 
                                          "totalPages"=>"233445")
    end
  end
end
