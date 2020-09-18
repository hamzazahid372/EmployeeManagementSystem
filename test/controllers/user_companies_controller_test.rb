require 'test_helper'

class UserCompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get user_companies_find_url
    assert_response :success
  end

end
