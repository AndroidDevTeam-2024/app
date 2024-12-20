require "test_helper"

class CommoditiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commodity = commodities(:one)
  end

  test "should get index" do
    get commodities_url
    assert_response :success
  end

  test "should get new" do
    get new_commodity_url
    assert_response :success
  end

  test "should create commodity" do
    assert_difference("Commodity.count") do
      post commodities_url, params: { commodity: { business_id: @commodity.business_id, exist: @commodity.exist, homepage: @commodity.homepage, introduction: @commodity.introduction, name: @commodity.name, price: @commodity.price } }
    end

    assert_redirected_to commodity_url(Commodity.last)
  end

  test "should show commodity" do
    get commodity_url(@commodity)
    assert_response :success
  end

  test "should get edit" do
    get edit_commodity_url(@commodity)
    assert_response :success
  end

  test "should update commodity" do
    patch commodity_url(@commodity), params: { commodity: { business_id: @commodity.business_id, exist: @commodity.exist, homepage: @commodity.homepage, introduction: @commodity.introduction, name: @commodity.name, price: @commodity.price } }
    assert_redirected_to commodity_url(@commodity)
  end

  test "should destroy commodity" do
    assert_difference("Commodity.count", -1) do
      delete commodity_url(@commodity)
    end

    assert_redirected_to commodities_url
  end
end
