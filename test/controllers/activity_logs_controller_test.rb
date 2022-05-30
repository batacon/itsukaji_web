# frozen_string_literal: true

require 'test_helper'

class ActivityLogsControllerTest < ActionDispatch::IntegrationTest
  describe 'ログイン時' do
    before { create_user_and_log_in }

    describe 'index' do
      it 'アクティビティログ一覧画面を正しく表示' do
        get activity_logs_url
        assert_response :success
      end
    end
  end

  describe 'ログアウト時' do
    describe 'index' do
      it 'ログインしていなければトップページへリダイレクト' do
        get activity_logs_url
        assert_redirected_to root_url
      end
    end
  end
end
