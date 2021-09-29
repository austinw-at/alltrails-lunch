require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favorite = favorites(:one)
  end

  test "should return array of favorites" do
    get api_v1_favorites_url, headers: {
      Authorization: token_auth(users(:api_user).token)
    }, as: :json

    assert_response :success
    assert_match @favorite.place_id, @response.body
  end

  test "should create new favorite" do
    post api_v1_favorites_url, headers: {
      Authorization: token_auth(users(:api_user).token)
    }, params: {
      favorite: {
        place_id: "testplaceid"
      }
    }, as: :json

    assert_response :success
    assert_match "testplaceid", @response.body
  end

  test "should not create a duplicate favorite" do
    post api_v1_favorites_url, headers: {
      Authorization: token_auth(users(:api_user).token)
    }, params: {
      favorite: {
        place_id: @favorite.place_id
      }
    }, as: :json

    assert_response :unprocessable_entity
    assert_match "Place has already been taken", @response.body
  end

  test "should destroy favorite" do
    favorite = favorites(:one)
    assert_difference("Favorite.count", -1) do
      delete api_v1_favorite_url(favorite), headers: {
        Authorization: token_auth(users(:api_user).token)
      }, as: :json
    end

    assert_response :success
  end
end