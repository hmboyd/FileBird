require "test_helper"

class DownloadersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @downloader = downloaders(:one)
  end

  test "should get index" do
    get downloaders_url
    assert_response :success
  end

  test "should get new" do
    get new_downloader_url
    assert_response :success
  end

  test "should create downloader" do
    assert_difference('Downloader.count') do
      post downloaders_url, params: { downloader: { ftp_path: @downloader.ftp_path, rename: @downloader.rename, rename_prefix: @downloader.rename_prefix, setting_id: @downloader.setting_id } }
    end

    assert_redirected_to downloader_url(Downloader.last)
  end

  test "should show downloader" do
    get downloader_url(@downloader)
    assert_response :success
  end

  test "should get edit" do
    get edit_downloader_url(@downloader)
    assert_response :success
  end

  test "should update downloader" do
    patch downloader_url(@downloader), params: { downloader: { ftp_path: @downloader.ftp_path, rename: @downloader.rename, rename_prefix: @downloader.rename_prefix, setting_id: @downloader.setting_id } }
    assert_redirected_to downloader_url(@downloader)
  end

  test "should destroy downloader" do
    assert_difference('Downloader.count', -1) do
      delete downloader_url(@downloader)
    end

    assert_redirected_to downloaders_url
  end
end
