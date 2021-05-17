require "application_system_test_case"

class MovesTest < ApplicationSystemTestCase
  setup do
    @move = moves(:one)
  end

  test "visiting the index" do
    visit moves_url
    assert_selector "h1", text: "Moves"
  end

  test "creating a Move" do
    visit moves_url
    click_on "New Move"

    fill_in "Name", with: @move.name
    click_on "Create Move"

    assert_text "Move was successfully created"
    click_on "Back"
  end

  test "updating a Move" do
    visit moves_url
    click_on "Edit", match: :first

    fill_in "Name", with: @move.name
    click_on "Update Move"

    assert_text "Move was successfully updated"
    click_on "Back"
  end

  test "destroying a Move" do
    visit moves_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Move was successfully destroyed"
  end
end
