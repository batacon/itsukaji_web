# frozen_string_literal: true

require 'test_helper'

class RepetitiveTaskLogComponentTest < ViewComponent::TestCase
  it '今日のログが正しく表示される' do
    repetitive_task_log = repetitive_task_logs(:today)
    render_inline(RepetitiveTaskLogComponent.new(repetitive_task_log:))
    assert_text '今日'
  end

  it '昨日のログが正しく表示される' do
    repetitive_task_log = repetitive_task_logs(:yesterday)
    render_inline(RepetitiveTaskLogComponent.new(repetitive_task_log:))
    assert_text '1日前'
  end
end
