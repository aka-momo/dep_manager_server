require 'test_helper'

class Api::V1::PackagesControllerTest < ActionDispatch::IntegrationTest
  test "should post fetch" do
  	# TODO: TESTS
    post api_v1_packages_fetch_url
    assert_response :success
  end

end
