# frozen_string_literal: true

class ArtistsController < ApplicationController
  def show
    service = LastFmFinder.new(params['page'])
    @tracks = service.get_top_tracks(params['name'])
    @summary = service.summary
  end

  def index
    service = LastFmFinder.new(params['page'])
    @artists = service.get_top_artists(params['country'])
    @summary = service.summary
  end
end
