require "application_system_test_case"

class StancesTest < ApplicationSystemTestCase
  setup do
    @stance = stances(:one)
  end

  test "visiting the index" do
    visit stances_url
    assert_selector "h1", text: "Stances"
  end

  test "creating a Stance" do
    visit stances_url
    click_on "New Stance"

    fill_in "Character", with: @stance.character_id
    fill_in "Desc", with: @stance.desc
    fill_in "Name", with: @stance.name
    click_on "Create Stance"

    assert_text "Stance was successfully created"
    click_on "Back"
  end

  test "updating a Stance" do
    visit stances_url
    click_on "Edit", match: :first

    fill_in "Character", with: @stance.character_id
    fill_in "Desc", with: @stance.desc
    fill_in "Name", with: @stance.name
    click_on "Update Stance"

    assert_text "Stance was successfully updated"
    click_on "Back"
  end

  test "destroying a Stance" do
    visit stances_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stance was successfully destroyed"
  end
end
