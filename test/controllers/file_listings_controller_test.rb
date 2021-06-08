require "test_helper"

class FileListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @file_listing = file_listings(:one)
  end

  test "should get index" do
    get file_listings_url
    assert_response :success
  end

  test "should get new" do
    get new_file_listing_url
    assert_response :success
  end

  test "should create file_listing" do
    assert_difference('FileListing.count') do
      post file_listings_url, params: { file_listing: { file_name: @file_listing.file_name, file_path: @file_listing.file_path, last_modified: @file_listing.last_modified } }
    end

    assert_redirected_to file_listing_url(FileListing.last)
  end

  test "should show file_listing" do
    get file_listing_url(@file_listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_file_listing_url(@file_listing)
    assert_response :success
  end

  test "should update file_listing" do
    patch file_listing_url(@file_listing), params: { file_listing: { file_name: @file_listing.file_name, file_path: @file_listing.file_path, last_modified: @file_listing.last_modified } }
    assert_redirected_to file_listing_url(@file_listing)
  end

  test "should destroy file_listing" do
    assert_difference('FileListing.count', -1) do
      delete file_listing_url(@file_listing)
    end

    assert_redirected_to file_listings_url
  end
end
