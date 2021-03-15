# frozen_string_literal: true

class ArtistsController < ApplicationController
  def show
    @name = params['name']

    client = LastFmFinder.new(params['page'])
    @tracks = client.get_top_tracks(@name)

    prepare_render(client)
  end

  def index
    @country = params['country']

    client = LastFmFinder.new(params['page'])
    @artists = client.get_top_artists(@country)

    prepare_render(client)
  end

  protected

  def prepare_render(client)
    @pagination = client.pagination
    flash.now[:error] = client.error unless client.error.blank?
  end
end
