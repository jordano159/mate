# frozen_string_literal: true

require 'application_system_test_case'

class AxesTest < ApplicationSystemTestCase
  setup do
    @axis = axes(:one)
  end

  test 'visiting the index' do
    visit axes_url
    assert_selector 'h1', text: 'Axes'
  end

  test 'creating a Axis' do
    visit axes_url
    click_on 'New Axis'

    fill_in 'Name', with: @axis.name
    click_on 'Create Axis'

    assert_text 'Axis was successfully created'
    click_on 'Back'
  end

  test 'updating a Axis' do
    visit axes_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @axis.name
    click_on 'Update Axis'

    assert_text 'Axis was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Axis' do
    visit axes_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Axis was successfully destroyed'
  end
end
