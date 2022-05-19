# frozen_string_literal: true

require 'test_helper'

class HeaderComponentTest < ViewComponent::TestCase
  it '正しく表示される' do
    render_inline(HeaderComponent.new(current_user: users(:member1_of_group1)))
    images = page.all('img')
    expect(images.size).must_equal 2
    expect(page.first(:css, 'a')[:href]).must_equal '/repetitive_tasks'
    expect(images[0][:src]).must_include 'header_logo'
    expect(images[1][:src]).must_include 'icon_three_dots'
  end

  it 'ログインしていない場合はロゴしか表示されない' do
    render_inline(HeaderComponent.new(current_user: nil))
    images = page.all('img')
    expect(images.size).must_equal 1
    expect(images[0][:src]).must_include 'header_logo'
  end
end
