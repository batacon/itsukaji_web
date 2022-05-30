# frozen_string_literal: true

require 'test_helper'

class HeaderComponentTest < ViewComponent::TestCase
  let(:images) { page.all('img') }

  it '正しく表示される' do
    render_inline(HeaderComponent.new(current_user: users(:member1_of_group1)))

    a_tags = page.all('a')
    expect(a_tags[0][:href]).must_equal '/repetitive_tasks'
    expect(a_tags[1][:href]).must_equal '/activity_logs'

    expect(images.size).must_equal 3
    expect(images[0][:src]).must_include 'header_logo'
    expect(images[1][:src]).must_include 'icon_activity_white'
    expect(images[2][:src]).must_include 'icon_three_dots'
  end

  it '未読のアクティビティが自分によるものだけの場合はベルアイコンを白にする' do
    ActivityLog.create!(
      user_group: users(:member1_of_group1).group,
      user: users(:member1_of_group1),
      loggable: ActivityLogs::TaskCreateLog.new(repetitive_task: repetitive_tasks(:done_today))
    )
    render_inline(HeaderComponent.new(current_user: users(:member1_of_group1)))
    expect(images[1][:src]).must_include 'icon_activity_white'
  end

  it '自分以外による未読のアクティビティがある場合はベルアイコンを赤色にする' do
    ActivityLog.create!(
      user_group: users(:member2_of_group1).group,
      user: users(:member2_of_group1),
      loggable: ActivityLogs::TaskCreateLog.new(repetitive_task: repetitive_tasks(:done_today))
    )
    render_inline(HeaderComponent.new(current_user: users(:member1_of_group1)))
    expect(images[1][:src]).must_include 'icon_activity_red'
  end

  it 'ログインしていない場合はロゴしか表示されない' do
    render_inline(HeaderComponent.new(current_user: nil))

    expect(images.size).must_equal 1
    expect(images[0][:src]).must_include 'header_logo'
  end
end
