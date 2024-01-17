require "application_system_test_case"

class DashboardsTest < ApplicationSystemTestCase
  test "visiting the dashboard" do
    visit dashboard_index_url
  
    assert_selector "h2", text: "Flash Message Example"
  end
end
