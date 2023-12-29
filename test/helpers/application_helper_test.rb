require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test '#nav_link generates the correct classes for a normal link' do
    link_path = '/normal_link'
    link = nav_link(path: link_path, text: 'Normal Link')
    assert_includes link, 'text-gray-700'
    assert_includes link, 'hover:text-primary-600'
    assert_includes link, 'hover:bg-gray-50'
  end

  test '#nav_link generates the correct classes for a current link' do
    link_path = '/normal_link'
    link = nav_link(path: link_path, text: 'Normal Link')

    stub :current_page?, true do
      link = nav_link(path: link_path, text: 'Current Link')
      assert_includes link, 'text-primary-600', 'bg-gray-50'
    end
  end
end