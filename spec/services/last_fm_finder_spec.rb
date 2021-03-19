# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LastFmFinder do
  let(:service) { LastFmFinder.new }
  describe '#as_hash' do
    it 'shoud retrieve Brazil\'s top 5 artists' do
      expect(service.get_top_artists('Brazil').size).to eq(5)
      expect(service.summary['country']).to eq('Brazil')
      expect(service.summary['page']).to eq('1')
      expect(service.summary['perPage']).to eq('5')
    end
    it 'shoud retrieve Rihanna top 5 tracks' do
      expect(service.get_top_tracks('Rihanna').size).to eq(5)
      expect(service.summary['artist']).to eq('Rihanna')
      expect(service.summary['page']).to eq('1')
      expect(service.summary['perPage']).to eq('5')
    end
  end
end
