# frozen_string_literal: true

require 'test_helper'

class RepetitiveTasksControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  let(:repetitive_task_params) { { name: 'test', interval_days: 1 } }

  describe 'ログイン時' do
    before do
      @current_user = create_user_and_log_in
      @repetitive_task = @current_user.group.repetitive_tasks.create!(repetitive_task_params)
    end

    let(:other_groups_task) { repetitive_tasks(:done_today) }

    describe 'index' do
      it 'タスク一覧画面を正しく表示' do
        get repetitive_tasks_path
        assert_response :success
      end
    end

    describe 'new' do
      it 'タスク新規画面を表示' do
        get new_repetitive_task_path
        assert_response :success
      end
    end

    describe 'create' do
      it 'last_done_at無しなら、タスクのみを作成し、タスク一覧画面にリダイレクト' do
        assert_difference 'RepetitiveTask.count', 1 do
          assert_difference 'RepetitiveTaskLog.count', 0 do
            assert_difference 'ActivityLogs::TaskCreateLog.count', 1 do
              post repetitive_tasks_path, params: { repetitive_task: repetitive_task_params }
            end
          end
        end
        assert_redirected_to repetitive_tasks_path
      end

      it 'last_done_atありなら、タスクとログを作成し、タスク一覧画面にリダイレクト' do
        last_done_at = Date.yesterday
        assert_difference 'RepetitiveTask.count', 1 do
          assert_difference 'RepetitiveTaskLog.count', 1 do
            assert_difference 'ActivityLogs::TaskCreateLog.count', 1 do
              post repetitive_tasks_path, params: { repetitive_task: repetitive_task_params.merge(last_done_at:) }
            end
          end
        end
        assert_redirected_to repetitive_tasks_path
      end
    end

    describe 'edit' do
      it 'タスク編集画面を表示' do
        get edit_repetitive_task_path(@repetitive_task)
        assert_response :success
      end

      it '他のグループのタスクは表示できない' do
        get edit_repetitive_task_path(other_groups_task)
        assert_redirected_to repetitive_tasks_path
      end
    end

    describe 'update' do
      it 'タスクを更新し、タスク一覧画面にリダイレクト' do
        put repetitive_task_path(@repetitive_task), params: { repetitive_task: { name: 'test2' } }
        expect(@repetitive_task.reload.name).must_equal 'test2'
        assert_redirected_to repetitive_tasks_path
      end

      it '他のグループのタスクは更新できない' do
        put repetitive_task_path(other_groups_task), params: { repetitive_task: { name: 'test2' } }
        expect(other_groups_task.reload.name).wont_equal 'test2'
        assert_redirected_to repetitive_tasks_path
      end
    end

    describe 'destroy' do
      it 'タスクを削除し、タスク一覧画面にリダイレクト' do
        assert_difference 'RepetitiveTask.count', -1 do
          assert_difference 'ActivityLogs::TaskDeleteLog.count', 1 do
            delete repetitive_task_path(@repetitive_task)
          end
        end
        assert_redirected_to repetitive_tasks_path
      end

      it '他のグループのタスクは削除できない' do
        assert_difference 'RepetitiveTask.count', 0 do
          delete repetitive_task_path(other_groups_task)
        end
        assert_redirected_to repetitive_tasks_path
      end
    end
  end

  describe 'ログアウト時' do
    let(:repetitive_task) { repetitive_tasks(:done_today) }

    describe 'index' do
      it 'ログインしていなければトップページへリダイレクト' do
        get repetitive_tasks_path
        assert_redirected_to root_url
      end
    end

    describe 'new' do
      it 'ログインしていなければトップページへリダイレクト' do
        get new_repetitive_task_path
        assert_redirected_to root_url
      end
    end

    describe 'create' do
      it 'ログインしていなければトップページへリダイレクト' do
        assert_difference 'RepetitiveTask.count', 0 do
          post repetitive_tasks_path, params: { repetitive_task: repetitive_task_params }
        end
        assert_redirected_to root_url
      end
    end

    describe 'edit' do
      it 'ログインしていなければトップページへリダイレクト' do
        get edit_repetitive_task_path(repetitive_task)
        assert_redirected_to root_url
      end
    end

    describe 'update' do
      it 'ログインしていなければトップページへリダイレクト' do
        put repetitive_task_path(repetitive_task), params: { repetitive_task: { name: 'test2' } }
        expect(repetitive_task.reload.name).wont_equal 'test2'
        assert_redirected_to root_url
      end
    end

    describe 'destroy' do
      it 'ログインしていなければトップページへリダイレクト' do
        assert_difference 'RepetitiveTask.count', 0 do
          delete repetitive_task_path(repetitive_task)
        end
        assert_redirected_to root_url
      end
    end
  end
end
