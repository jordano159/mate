require 'test_helper'

class MifalsControllerTest < ActionDispatch::IntegrationTest
 include Devise::Test::IntegrationHelpers
  setup do
    @mifal = mifals(:one)
		sign_in staffs(:vip)
  end

   test "should get index" do
    get mifals_url
    assert_response :success
  end

  test "should get new" do
    get new_mifal_url
    assert_response :success
  end

  test "should create mifal" do
    assert_difference('Mifal.count') do
      post mifals_url, params: { mifal: { name: @mifal.name } }
    end

    assert_redirected_to mifal_url(Mifal.last)
  end

  test "should show mifal" do
    get mifal_url(@mifal)
    assert_response :success
  end

  test "should get edit" do
    get edit_mifal_url(@mifal)
    assert_response :success
  end

  test "should update mifal" do
    patch mifal_url(@mifal), params: { mifal: { name: @mifal.name } }
    assert_redirected_to mifal_url(@mifal)
  end

  test "should destroy mifal" do
    assert_difference('Mifal.count', -1) do
      delete mifal_url(@mifal)
    end

    assert_redirected_to mifals_url
  end
end
