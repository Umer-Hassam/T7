require "application_system_test_case"

class FanArtsTest < ApplicationSystemTestCase
  setup do
    @fan_art = fan_arts(:one)
  end

  test "visiting the index" do
    visit fan_arts_url
    assert_selector "h1", text: "Fan Arts"
  end

  test "creating a Fan art" do
    visit fan_arts_url
    click_on "New Fan Art"

    fill_in "Art type", with: @fan_art.art_type
    fill_in "Artist link", with: @fan_art.artist_link
    fill_in "Artist name", with: @fan_art.artist_name
    fill_in "Description", with: @fan_art.description
    fill_in "Is main", with: @fan_art.is_main
    fill_in "Link", with: @fan_art.link
    fill_in "Style", with: @fan_art.style
    click_on "Create Fan art"

    assert_text "Fan art was successfully created"
    click_on "Back"
  end

  test "updating a Fan art" do
    visit fan_arts_url
    click_on "Edit", match: :first

    fill_in "Art type", with: @fan_art.art_type
    fill_in "Artist link", with: @fan_art.artist_link
    fill_in "Artist name", with: @fan_art.artist_name
    fill_in "Description", with: @fan_art.description
    fill_in "Is main", with: @fan_art.is_main
    fill_in "Link", with: @fan_art.link
    fill_in "Style", with: @fan_art.style
    click_on "Update Fan art"

    assert_text "Fan art was successfully updated"
    click_on "Back"
  end

  test "destroying a Fan art" do
    visit fan_arts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fan art was successfully destroyed"
  end
end
