# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get privacy_policy' do
    get privacy_policy_path
    assert_response :success
  end
end
