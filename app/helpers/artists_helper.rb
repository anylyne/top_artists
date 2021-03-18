# frozen_string_literal: true

module ArtistsHelper
  def show_artist(summary)
    summary['artist'] if summary
  end

  def show_country(summary)
    summary['country'] if summary
  end

  def paginate(summary)
    Paginator.new(summary, request.path, action_name).paginate
  end
end
