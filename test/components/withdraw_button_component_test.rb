# frozen_string_literal: true

require "test_helper"

class WithdrawButtonComponentTest < ViewComponent::TestCase
  it 'current_userがownerの場合、正しく表示される' do
    current_user = users(:owner1)
    render_inline(WithdrawButtonComponent.new(current_user:))
    assert_selector 'button', text: '退会'
  end

  it 'current_userがownerでない場合、表示されない' do
    current_user = users(:member1_of_group1)
    render_inline(WithdrawButtonComponent.new(current_user:))
    assert_no_selector 'button'
  end
end
