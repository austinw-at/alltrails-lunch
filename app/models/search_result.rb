class SearchResult
  API_URL = "https://maps.googleapis.com/maps/api/place/".freeze

  attr_reader :id, :name, :location, :favorited

  def initialize(id:, name:, location:, photo_reference:, favorited: false)
    @id = id
    @name = name
    @location = location
    @photo_reference = photo_reference
    @favorited = favorited
  end

  def photo_url
    return unless @photo_reference

    "#{API_URL}photo?maxwidth=400&photo_reference=#{@photo_reference}&key=#{Rails.application.credentials.google_places_key!}"
  end
end
