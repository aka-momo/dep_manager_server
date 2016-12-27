require 'test_helper'

class Api::V1::PackagesControllerTest < ActionDispatch::IntegrationTest
  test 'should succesfully fetch' do
    post fetch_api_v1_packages_path, packages:  ['nokogiri'],
                                     language: 'ruby',
                                     os: 'mac'
    assert_response :success
  end

  test 'should fail to fetch due to language' do
    post fetch_api_v1_packages_path, packages:  ['nokogiri'],
                                     language: 'python',
                                     os: 'mac'
    assert_response :bad_request
  end

  test 'should fail to fetch due to OS' do
    post fetch_api_v1_packages_path, packages:  ['nokogiri'],
                                     language: 'ruby',
                                     os: 'windows'
    assert_response :bad_request
  end

  test 'should fail to fetch due to packages' do
    post fetch_api_v1_packages_path, packages:  1,
                                     language: 'ruby',
                                     os: 'mac'

    assert_response :unprocessable_entity
  end
end
