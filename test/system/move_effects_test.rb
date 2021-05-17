require "application_system_test_case"

class MoveEffectsTest < ApplicationSystemTestCase
  setup do
    @move_effect = move_effects(:one)
  end

  test "visiting the index" do
    visit move_effects_url
    assert_selector "h1", text: "Move Effects"
  end

  test "creating a Move effect" do
    visit move_effects_url
    click_on "New Move Effect"

    fill_in "Desc", with: @move_effect.desc
    fill_in "Image url", with: @move_effect.image_url
    fill_in "Name", with: @move_effect.name
    click_on "Create Move effect"

    assert_text "Move effect was successfully created"
    click_on "Back"
  end

  test "updating a Move effect" do
    visit move_effects_url
    click_on "Edit", match: :first

    fill_in "Desc", with: @move_effect.desc
    fill_in "Image url", with: @move_effect.image_url
    fill_in "Name", with: @move_effect.name
    click_on "Update Move effect"

    assert_text "Move effect was successfully updated"
    click_on "Back"
  end

  test "destroying a Move effect" do
    visit move_effects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Move effect was successfully destroyed"
  end
end
