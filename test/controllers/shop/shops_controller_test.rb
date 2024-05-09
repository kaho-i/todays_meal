require "test_helper"

class Shop::ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shop_shops_show_url
    assert_response :success
  end

  test "should get edit" do
    get shop_shops_edit_url
    assert_response :success
  end
end
