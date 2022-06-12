# frozen_string_literal: true

require 'test_helper'

class WithdrawButtonComponentTest < ViewComponent::TestCase
  it 'current_userがownerの場合、グループを削除するボタンになる' do
    current_user = users(:owner1)
    render_inline(WithdrawButtonComponent.new(label: 'グループ解散', current_user:))
    assert_selector 'button', text: 'グループ解散'
    # TODO: ボタンのhrefが正しいかどうかを確認する
  end

  it 'current_userがownerでない場合、そのユーザーを削除するボタンになる' do
    current_user = users(:member1_of_group1)
    render_inline(WithdrawButtonComponent.new(label: '退会', current_user:))
    assert_selector 'button', text: '退会'
    # TODO: ボタンのhrefが正しいかどうかを確認する
  end
end
