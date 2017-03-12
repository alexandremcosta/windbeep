require 'test_helper'

class UserSpotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bruno)
    sign_in @user
  end

  test "#create: should create user spots" do
    assert_difference "UserSpot.count" do
      post user_spots_url, params: {spot_creator: {url: 'www.windguru.cz/261814'}}
    end
    assert_redirected_to dashboard_url
  end

  test "#create should present errors" do
    assert_no_difference "UserSpot.count" do
      post user_spots_url, params: {spot_creator: {url: 'www.invalid.url/261814'}}
    end
  end
end
