# frozen_string_literal: true

require "test_helper"

class RepetitiveTaskComponentTest < ViewComponent::TestCase
  it '今日やったタスクが正しく表示される' do
    repetitive_task = repetitive_tasks(:done_today)
    render_inline(RepetitiveTaskComponent.new(repetitive_task:))
    assert_text repetitive_task.name
  end

  it '今日やってないタスクが正しく表示される' do
    repetitive_task = repetitive_tasks(:without_logs)
    render_inline(RepetitiveTaskComponent.new(repetitive_task:))
    assert_text repetitive_task.name
  end
end
