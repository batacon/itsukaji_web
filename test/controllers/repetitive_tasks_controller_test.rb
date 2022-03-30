require "test_helper"

class RepetitiveTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get repetitive_tasks_index_url
    assert_response :success
  end

  test "should get show" do
    get repetitive_tasks_show_url
    assert_response :success
  end

  test "should get new" do
    get repetitive_tasks_new_url
    assert_response :success
  end

  test "should get edit" do
    get repetitive_tasks_edit_url
    assert_response :success
  end
end
