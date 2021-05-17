require "application_system_test_case"

class FollowupsTest < ApplicationSystemTestCase
  setup do
    @followup = followups(:one)
  end

  test "visiting the index" do
    visit followups_url
    assert_selector "h1", text: "Followups"
  end

  test "creating a Followup" do
    visit followups_url
    click_on "New Followup"

    fill_in "Explanation", with: @followup.explanation
    fill_in "Hit status", with: @followup.hit_status
    check "Is guaranteed" if @followup.is_guaranteed
    click_on "Create Followup"

    assert_text "Followup was successfully created"
    click_on "Back"
  end

  test "updating a Followup" do
    visit followups_url
    click_on "Edit", match: :first

    fill_in "Explanation", with: @followup.explanation
    fill_in "Hit status", with: @followup.hit_status
    check "Is guaranteed" if @followup.is_guaranteed
    click_on "Update Followup"

    assert_text "Followup was successfully updated"
    click_on "Back"
  end

  test "destroying a Followup" do
    visit followups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Followup was successfully destroyed"
  end
end
