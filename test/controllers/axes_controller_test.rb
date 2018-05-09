require 'test_helper'

class AxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @axis = axes(:one)
  end

  test "should get index" do
    get axes_url
    assert_response :success
  end

  test "should get new" do
    get new_axis_url
    assert_response :success
  end

  test "should create axis" do
    assert_difference('Axis.count') do
      post axes_url, params: { axis: { name: @axis.name } }
    end

    assert_redirected_to axis_url(Axis.last)
  end

  test "should show axis" do
    get axis_url(@axis)
    assert_response :success
  end

  test "should get edit" do
    get edit_axis_url(@axis)
    assert_response :success
  end

  test "should update axis" do
    patch axis_url(@axis), params: { axis: { name: @axis.name } }
    assert_redirected_to axis_url(@axis)
  end

  test "should destroy axis" do
    assert_difference('Axis.count', -1) do
      delete axis_url(@axis)
    end

    assert_redirected_to axes_url
  end
end
