# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LastFmFinder, type: :model do
  describe '#as_hash' do
    it 'shoud retrieve Brazil\'s top 5 artists' do
      service = LastFmFinder.new()
      expect(service.get_top_artists("Brazil").size).to eq(5)
      expect(service.summary).to eq("country"=>"Brazil", 
                                    "page"=>"1", 
                                    "perPage"=>"5", 
                                    "total"=>"1167222", 
                                    "totalPages"=>"233445")
    end
    it 'shoud retrieve Rihanna top 5 tracks' do
      service = LastFmFinder.new()
      expect(service.get_top_tracks("Rihanna").size).to eq(5)
      expect(service.summary).to eq("artist"=>"Rihanna", 
                                    "page"=>"1", 
                                    "perPage"=>"5", 
                                    "total"=>"190748", 
                                    "totalPages"=>"38150")
    end
  end
end
