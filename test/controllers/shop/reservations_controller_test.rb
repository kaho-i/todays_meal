require "test_helper"

class Shop::ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shop_reservations_index_url
    assert_response :success
  end

  test "should get show" do
    get shop_reservations_show_url
    assert_response :success
  end

  test "should get edit" do
    get shop_reservations_edit_url
    assert_response :success
  end
end
