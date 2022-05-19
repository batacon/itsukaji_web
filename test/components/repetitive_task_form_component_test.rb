# frozen_string_literal: true

require 'test_helper'

class RepetitiveTaskFormComponentTest < ViewComponent::TestCase
  it '新規作成フォームが正しく表示される' do
    repetitive_task = RepetitiveTask.new
    render_inline(RepetitiveTaskFormComponent.new(repetitive_task:))
    assert_text '前やった日'
  end

  it '編集フォームが正しく表示される' do
    repetitive_task = repetitive_tasks(:done_today)
    render_inline(RepetitiveTaskFormComponent.new(repetitive_task:))
    assert_no_text '前やった日'
  end
end
