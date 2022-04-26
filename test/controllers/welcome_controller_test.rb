require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  describe 'index' do
    it '招待コード入力ページを正しく表示' do
      get welcome_index_path, params: { user: { name: 'test', email: 'aaa@gmail.com' } }
      assert_response :success
    end

    it 'paramsが無ければトップページへリダイレクト' do
      get welcome_index_path
      assert_redirected_to root_url
    end
  end
end
