require "test_helper"

class AccessoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accessories_index_url
    assert_response :success
  end

  test "should get show" do
    get accessories_show_url
    assert_response :success
  end

  test "should get destroy" do
    get accessories_destroy_url
    assert_response :success
  end
end
