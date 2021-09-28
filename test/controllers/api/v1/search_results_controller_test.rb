require "test_helper"

class SearchResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get results" do
    VCR.use_cassette("google_places_tacos") do
      post search_url, headers: {
        Authorization: token_auth(users(:api_user).token)
      }, params: {
        search: {
          query: "tacos",
          latlong: "40.2969,-111.6946"
        }
      }, as: :json

      assert_response :success
    end
  end

  test "should get error missing params" do
    post search_url, headers: {
      Authorization: token_auth(users(:api_user).token)
    }
    assert_response :unprocessable_entity, "param is missing or the value is empty: search"
  end

  def token_auth(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end
