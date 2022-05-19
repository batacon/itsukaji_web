# frozen_string_literal: true

require 'test_helper'

class TaskCardComponentTest < ViewComponent::TestCase
  it '今日やるべきタスクが正しく表示される' do
    repetitive_task = repetitive_tasks(:without_logs)
    render_inline(TaskCardComponent.new(repetitive_task:))
    assert_text repetitive_task.name

    images = page.all('img')
    expect(images.size).must_equal 1
    expect(images[0]['src']).must_include 'icon_bell_red'
  end

  it '今日やらなくてもいいタスクが正しく表示される' do
    repetitive_task = repetitive_tasks(:done_today)
    render_inline(TaskCardComponent.new(repetitive_task:))
    assert_text repetitive_task.name

    images = page.all('img')
    expect(images.size).must_equal 2
    expect(images[0]['src']).must_include 'icon_calendar_check_blue'
    expect(images[1]['src']).must_include 'icon_bell_blue'
  end
end
