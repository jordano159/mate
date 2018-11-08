# frozen_string_literal: true

require 'test_helper'

class HeadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @head = heads(:one)
  end

  test 'should get index' do
    get heads_url
    assert_response :success
  end

  test 'should get new' do
    get new_head_url
    assert_response :success
  end

  test 'should create head' do
    assert_difference('Head.count') do
      post heads_url, params: { head: { name: @head.name } }
    end

    assert_redirected_to head_url(Head.last)
  end

  test 'should show head' do
    get head_url(@head)
    assert_response :success
  end

  test 'should get edit' do
    get edit_head_url(@head)
    assert_response :success
  end

  test 'should update head' do
    patch head_url(@head), params: { head: { name: @head.name } }
    assert_redirected_to head_url(@head)
  end

  test 'should destroy head' do
    assert_difference('Head.count', -1) do
      delete head_url(@head)
    end

    assert_redirected_to heads_url
  end
end
