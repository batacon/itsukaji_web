require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  it 'トップページを表示' do
    get root_url
    assert_response :success
  end

  it 'ログインしていればタスク一覧画面へリダイレクトする' do
    create_user_and_log_in
    get root_url
    assert_redirected_to repetitive_tasks_url
  end
end
