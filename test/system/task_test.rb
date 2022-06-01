# frozen_string_literal: true

require 'application_system_test_case'

class TaskTest < ApplicationSystemTestCase
  it 'タスクを作成し、完了し、やったログを編集し、削除する' do
    visit root_path
    click_on 'Log in'
    click_on 'アカウント作成'

    # タスク一覧画面
    click_link 'create-task'

    # 新規作成画面
    visit current_path
    fill_in 'repetitive_task[name]', with: 'test task'
    fill_in 'repetitive_task[interval_days]', with: '1'
    click_on '保存する'

    # タスク一覧画面
    assert_text 'test task'
    assert_text 'every day'
    assert_text 'やりましょう'

    click_button 'done-button'
    assert_text 'あと 1日'
    click_on 'test task'

    # 編集画面
    assert_text 'やった！ログ'
    visit current_path
    fill_in :repetitive_task_log_date, with: '2022-01-11' # FIXME: 何を入れても'2022-02-01'を選択したことになる
    # assert_text "#{(Date.today - Date.new(2022, 1, 11)).to_i}日前"
    click_link 'back-link'

    # タスク一覧画面
    assert_text 'やりましょう'
    click_button 'done-button'
    assert_text 'あと 1日'
    click_on 'test task'

    # 編集画面
    assert_text 'やった！ログ'
    # fill_in :repetitive_task_log_date, with: '2022-02-22' # FIXME: フォームが二つあるので特定する必要がある
    # assert_text "#{(Date.today - Date.new(2022, 2, 22)).to_i}日前" # TODO: 2つログを作った後新しい方のdateを変更しようとしても変わらなくなったバグがあったので回帰テスト
  end
end
