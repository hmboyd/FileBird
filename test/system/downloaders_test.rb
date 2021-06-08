require "application_system_test_case"

class DownloadersTest < ApplicationSystemTestCase
  setup do
    @downloader = downloaders(:one)
  end

  test "visiting the index" do
    visit downloaders_url
    assert_selector "h1", text: "Downloaders"
  end

  test "creating a Downloader" do
    visit downloaders_url
    click_on "New Downloader"

    fill_in "Ftp path", with: @downloader.ftp_path
    check "Rename" if @downloader.rename
    fill_in "Rename prefix", with: @downloader.rename_prefix
    fill_in "Setting", with: @downloader.setting_id
    click_on "Create Downloader"

    assert_text "Downloader was successfully created"
    click_on "Back"
  end

  test "updating a Downloader" do
    visit downloaders_url
    click_on "Edit", match: :first

    fill_in "Ftp path", with: @downloader.ftp_path
    check "Rename" if @downloader.rename
    fill_in "Rename prefix", with: @downloader.rename_prefix
    fill_in "Setting", with: @downloader.setting_id
    click_on "Update Downloader"

    assert_text "Downloader was successfully updated"
    click_on "Back"
  end

  test "destroying a Downloader" do
    visit downloaders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Downloader was successfully destroyed"
  end
end
