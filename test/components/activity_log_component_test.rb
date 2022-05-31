# frozen_string_literal: true

require 'test_helper'

class ActivityLogComponentTest < ViewComponent::TestCase
  it '自分のアクティビティが正しく表示される' do
    user = users(:member1_of_group1)
    user_group = user.group
    repetitive_task = repetitive_tasks(:without_logs)
    activity_log = ActivityLog.create!(user:, user_group:, loggable: ActivityLogs::TaskDoneLog.new(repetitive_task:) )

    render_inline(ActivityLogComponent.new(activity_log:, current_user: user))
    assert_text activity_log.text
    assert_text activity_log.created_at.strftime('%Y-%m-%d %H:%M')
  end
end
