require 'test_helper'

class FanArtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fan_art = fan_arts(:one)
  end

  test "should get index" do
    get fan_arts_url
    assert_response :success
  end

  test "should get new" do
    get new_fan_art_url
    assert_response :success
  end

  test "should create fan_art" do
    assert_difference('FanArt.count') do
      post fan_arts_url, params: { fan_art: { art_type: @fan_art.art_type, artist_link: @fan_art.artist_link, artist_name: @fan_art.artist_name, description: @fan_art.description, is_main: @fan_art.is_main, link: @fan_art.link, style: @fan_art.style } }
    end

    assert_redirected_to fan_art_url(FanArt.last)
  end

  test "should show fan_art" do
    get fan_art_url(@fan_art)
    assert_response :success
  end

  test "should get edit" do
    get edit_fan_art_url(@fan_art)
    assert_response :success
  end

  test "should update fan_art" do
    patch fan_art_url(@fan_art), params: { fan_art: { art_type: @fan_art.art_type, artist_link: @fan_art.artist_link, artist_name: @fan_art.artist_name, description: @fan_art.description, is_main: @fan_art.is_main, link: @fan_art.link, style: @fan_art.style } }
    assert_redirected_to fan_art_url(@fan_art)
  end

  test "should destroy fan_art" do
    assert_difference('FanArt.count', -1) do
      delete fan_art_url(@fan_art)
    end

    assert_redirected_to fan_arts_url
  end
end
