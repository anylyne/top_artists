# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  describe 'GET show artist' do
    it 'returns a 200' do
      get :show, params: { name: 'Rihanna' }
      expect(response).to have_http_status(:ok)
      expect(assigns(:tracks).size).to eq(5)
      expect(assigns(:summary)['artist']).to eq('Rihanna')
      expect(assigns(:summary)['page']).to eq('1')
      expect(assigns(:summary)['perPage']).to eq('5')
    end
  end
  describe 'GET index' do
    it 'returns a 200' do
      get :index, params: { country: 'Brazil' }
      expect(response).to have_http_status(:ok)
      expect(assigns(:artists).size).to eq(5)
      expect(assigns(:summary)['country']).to eq('Brazil')
      expect(assigns(:summary)['page']).to eq('1')
      expect(assigns(:summary)['perPage']).to eq('5')
    end
  end
end
