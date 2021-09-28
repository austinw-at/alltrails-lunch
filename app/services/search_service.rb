require "net/http"

class SearchService < ApplicationService
  PLACES_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json".freeze
  RADIUS = 2000
  TYPE = "restaurant".freeze

  def initialize(search_params)
    super()

    @query = search_params["query"]
    @latlong = search_params["latlong"]
    @type = search_params["type"]&.presence || TYPE
  end

  def call
    search_results
  end

  private

  def search_results
    res = JSON.parse(places_search.body)

    res["status"] == "OK" ? build_results(res) : []
  end

  def places_search
    uri = URI(PLACES_URL)

    params = {
      keyword: @query,
      location: @latlong,
      radius: RADIUS,
      type: @type,
      key: Rails.application.credentials.google_places_key!
    }

    uri.query = URI.encode_www_form(params)

    Net::HTTP.get_response(uri)
  end

  def build_results(results)
    results["results"].map do |result|
      latlong = "#{result['geometry']['location']['lat']},#{result['geometry']['location']['lng']}"
      photo_ref = result.dig("photos", 0, "photo_reference")

      SearchResult.new(
        id: result["place_id"],
        name: result["name"],
        location: latlong,
        photo_reference: photo_ref
      )
    end
  end
end
