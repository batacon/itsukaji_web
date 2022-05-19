# frozen_string_literal: true

require 'test_helper'

class HeaderMenuComponentTest < ViewComponent::TestCase
  it '正しく表示される' do
    render_inline(HeaderMenuComponent.new)
    dots = page.find('img')
    expect(dots[:src]).must_include 'icon_three_dots'

    a_tags = page.all('a')
    expect(a_tags[0][:href]).must_equal '/user_groups'
    expect(a_tags[0].text).must_equal '招待・共有設定'
    expect(a_tags[1][:href]).must_equal '/log_out'
    expect(a_tags[1].text).must_equal 'ログアウト'
  end
end
