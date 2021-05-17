require 'test_helper'

class PurposesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purpose = purposes(:one)
  end

  test "should get index" do
    get purposes_url
    assert_response :success
  end

  test "should get new" do
    get new_purpose_url
    assert_response :success
  end

  test "should create purpose" do
    assert_difference('Purpose.count') do
      post purposes_url, params: { purpose: { desc: @purpose.desc, name: @purpose.name } }
    end

    assert_redirected_to purpose_url(Purpose.last)
  end

  test "should show purpose" do
    get purpose_url(@purpose)
    assert_response :success
  end

  test "should get edit" do
    get edit_purpose_url(@purpose)
    assert_response :success
  end

  test "should update purpose" do
    patch purpose_url(@purpose), params: { purpose: { desc: @purpose.desc, name: @purpose.name } }
    assert_redirected_to purpose_url(@purpose)
  end

  test "should destroy purpose" do
    assert_difference('Purpose.count', -1) do
      delete purpose_url(@purpose)
    end

    assert_redirected_to purposes_url
  end
end
