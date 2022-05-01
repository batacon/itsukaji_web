# frozen_string_literal: true

require "test_helper"

class UserCreateFormSectionComponentTest < ViewComponent::TestCase
  let(:user) { { name: 'test_user', email: 'test@test.com' } }

  it '招待フォームが正しく表示される' do
    name, email = user[:name], user[:email]
    render_inline(UserCreateFormSectionComponent.new(name:, email:, by_invitation: true, class_name: 'mb-10'))
    assert_text '招待コードをお持ちの場合'
    expect(page.find('img')[:src]).must_include 'icon_group'
    assert_text '招待してくれた人のgmailアドレス'
    assert_text '招待コード'
    assert_selector 'input[type=submit][value=送信]'
  end

  it '招待無しフォームが正しく表示される' do
    name, email = user[:name], user[:email]
    render_inline(UserCreateFormSectionComponent.new(name:, email:))
    assert_text 'ひとりで使う、もしくは他の人を招待する場合'
    expect(page.find('img')[:src]).must_include 'icon_solo'
    assert_no_text '招待してくれた人のGmailアドレス'
    assert_no_text '招待コード'
    assert_selector 'input[type=submit][value=アカウント作成]'
  end
end
