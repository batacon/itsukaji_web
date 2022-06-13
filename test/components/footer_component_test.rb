# frozen_string_literal: true

require 'test_helper'

class FooterComponentTest < ViewComponent::TestCase
  it '正しく表示される' do
    render_inline(FooterComponent.new)

    a_tags = page.all('a')
    expect(a_tags[0][:href]).must_equal '/privacy_policy'
    expect(a_tags[0].text).must_equal 'プライバシーポリシー'
  end
end
