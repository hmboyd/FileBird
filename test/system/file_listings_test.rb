require "application_system_test_case"

class FileListingsTest < ApplicationSystemTestCase
  setup do
    @file_listing = file_listings(:one)
  end

  test "visiting the index" do
    visit file_listings_url
    assert_selector "h1", text: "File Listings"
  end

  test "creating a File listing" do
    visit file_listings_url
    click_on "New File Listing"

    fill_in "File name", with: @file_listing.file_name
    fill_in "File path", with: @file_listing.file_path
    fill_in "Last modified", with: @file_listing.last_modified
    click_on "Create File listing"

    assert_text "File listing was successfully created"
    click_on "Back"
  end

  test "updating a File listing" do
    visit file_listings_url
    click_on "Edit", match: :first

    fill_in "File name", with: @file_listing.file_name
    fill_in "File path", with: @file_listing.file_path
    fill_in "Last modified", with: @file_listing.last_modified
    click_on "Update File listing"

    assert_text "File listing was successfully updated"
    click_on "Back"
  end

  test "destroying a File listing" do
    visit file_listings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "File listing was successfully destroyed"
  end
end
