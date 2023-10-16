require "test_helper"

class ShopifywebhookControllerTest < ActionDispatch::IntegrationTest
  test "should get order_update" do
    get shopifywebhook_order_update_url
    assert_response :success
  end
end
