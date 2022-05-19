# frozen_string_literal: true

require 'test_helper'

class RepetitiveTaskLogsControllerTest < ActionDispatch::IntegrationTest
  let(:repetitive_task) { repetitive_tasks(:done_yesterday) }
  let(:repetitive_task_log) { repetitive_task_logs(:yesterday) }

  describe 'ログイン時' do
    before { create_user_and_log_in }

    describe 'create' do
      it '正常に作成できる' do
        assert_difference 'RepetitiveTaskLog.count', 1 do
          post repetitive_task_repetitive_task_logs_path(repetitive_task, format: :turbo_stream), params: { repetitive_task_id: repetitive_task.id }
        end
        assert_response :success
      end
    end

    describe 'update' do
      it '正常に編集できる' do
        put repetitive_task_repetitive_task_log_path(repetitive_task_log.repetitive_task, repetitive_task_log, format: :turbo_stream), params: { repetitive_task_log: { date: Date.today } }
        expect(repetitive_task_log.reload.date).must_equal Date.today
        assert_response :success
      end
    end

    describe 'destroy' do
      it '正常に削除できる' do
        assert_difference 'RepetitiveTaskLog.count', -1 do
          delete repetitive_task_repetitive_task_log_path(repetitive_task_log.repetitive_task, repetitive_task_log, format: :turbo_stream)
        end
        assert_response :success
      end
    end
  end

  describe 'ログアウト時' do
    describe 'create' do
      it 'トップページにリダイレクト' do
        assert_difference 'RepetitiveTaskLog.count', 0 do
          post repetitive_task_repetitive_task_logs_path(repetitive_task, format: :turbo_stream), params: { repetitive_task_id: repetitive_task.id }
        end
        assert_redirected_to root_url
      end
    end

    describe 'update' do
      it 'トップページにリダイレクト' do
        put repetitive_task_repetitive_task_log_path(repetitive_task_log.repetitive_task, repetitive_task_log, format: :turbo_stream), params: { repetitive_task_log: { date: Date.today } }
        expect(repetitive_task_log.reload.date).wont_equal Date.today
        assert_redirected_to root_url
      end
    end

    describe 'destroy' do
      it 'トップページにリダイレクト' do
        assert_difference 'RepetitiveTaskLog.count', 0 do
          delete repetitive_task_repetitive_task_log_path(repetitive_task_log.repetitive_task, repetitive_task_log, format: :turbo_stream)
        end
        assert_redirected_to root_url
      end
    end
  end
end
