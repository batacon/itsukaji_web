require "application_system_test_case"

class SignupTest < ApplicationSystemTestCase
  it "招待なしでオーナーとしてアカウント作成" do
    visit root_path
    click_on 'Log in'

    # 招待コード入力画面
    click_on 'アカウント作成'

    # タスク一覧画面
    assert_text 'タスクを新規作成するには、右下のプラスボタンを押してください。'
    click_button 'header-menu'
    click_on '招待・共有設定'

    # グループ画面
    assert_text '招待コード'
  end

  it "招待ありでアカウント作成" do
    owner = users(:owner1)
    visit root_path

    # 招待コード入力画面
    click_on 'Log in'
    fill_in :inviter_email, with: owner.email
    fill_in :invitation_code, with: owner.group.invitation_code
    click_on '送信'

    # タスク一覧画面
    owner.group.repetitive_tasks.each do |task|
      assert_text task.name
    end
    click_button 'header-menu'
    click_on '招待・共有設定'

    # グループ画面
    assert_no_text '招待コード'
  end
end
