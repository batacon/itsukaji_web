# frozen_string_literal: true

require 'test_helper'

class UserComponentTest < ViewComponent::TestCase
  it '自分がオーナーとして正しく表示される' do
    owner = users(:owner1)
    render_inline(UserComponent.new(user: owner, current_user: owner))
    assert_text '(自分/オーナー)'
    expect(page.all('img').size).must_equal 0
  end

  it '自分がメンバーの時にオーナーが正しく表示される' do
    owner = users(:owner1)
    render_inline(UserComponent.new(user: owner, current_user: users(:member1_of_group1)))
    assert_text '(オーナー)'
    expect(page.all('img').size).must_equal 0
  end

  it '自分がメンバーとして正しく表示される' do
    member = users(:member1_of_group1)
    render_inline(UserComponent.new(user: member, current_user: member))
    assert_text '(自分)'

    images = page.all('img')
    expect(images.size).must_equal 1
    expect(images[0]['src']).must_include 'icon_leave_group'
  end

  it '自分がオーナーの時にメンバーが正しく表示される' do
    owner = users(:owner1)
    render_inline(UserComponent.new(user: users(:member1_of_group1), current_user: owner))
    assert_no_text '自分'
    assert_no_text 'オーナー'

    images = page.all('img')
    expect(images.size).must_equal 1
    expect(images[0]['src']).must_include 'icon_delete_user'
  end
end
