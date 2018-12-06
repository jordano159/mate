require "application_system_test_case"

class MifalsTest < ApplicationSystemTestCase
  setup do
    @mifal = mifals(:one)
  end

  test "visiting the index" do
    visit mifals_url
    assert_selector "h1", text: "Mifals"
  end

  test "creating a Mifal" do
    visit mifals_url
    click_on "New Mifal"

    fill_in "Name", with: @mifal.name
    click_on "Create Mifal"

    assert_text "Mifal was successfully created"
    click_on "Back"
  end

  test "updating a Mifal" do
    visit mifals_url
    click_on "Edit", match: :first

    fill_in "Name", with: @mifal.name
    click_on "Update Mifal"

    assert_text "Mifal was successfully updated"
    click_on "Back"
  end

  test "destroying a Mifal" do
    visit mifals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mifal was successfully destroyed"
  end
end
