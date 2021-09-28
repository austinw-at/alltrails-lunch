require "net/http"

class SearchController < ApiBaseController
  RADIUS = 2000

  def index
    # Some Places API search
    @results = results
  end

  private

  def search_params
    params.require(:search).permit(:query, :latlong)
  end
  
  def search
    uri = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json")

    pp "params: #{search_params[:query]}"
    q_params = {
      keyword: search_params[:query],
      location: search_params[:latlong],
      radius: RADIUS,
      type: "restaurant",
      key: Rails.application.credentials.google_places_key!
    }

    uri.query = URI.encode_www_form(q_params)

    pp "query: #{uri}"

    Net::HTTP.get_response(uri)
  end

  def results
    res = JSON.parse(search.body)

    if res["status"] == "OK"
      build_results(res)
    else
      []
    end
  end

  def build_results(results)
    results["results"].map do |result|
      latlong = "#{result["geometry"]["location"]["lat"]},#{result["geometry"]["location"]["lng"]}"
      photo_ref = result.dig("photos", 0, "photo_reference")
      SearchResult.new(id: result["place_id"], name: result["name"], location: latlong, photo_reference: photo_ref)
    end
  end
end
