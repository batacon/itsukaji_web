# frozen_string_literal: true

require 'test_helper'

class ActivityLogComponentTest < ViewComponent::TestCase
  let(:user) { users(:member1_of_group1) }
  let(:user_group) { user.group }
  let(:repetitive_task) { repetitive_tasks(:without_logs) }

  it '自分のアクティビティがハイライト無しで表示される' do
    activity_log = ActivityLog.create!(user:, user_group:, loggable: ActivityLogs::TaskDoneLog.new(repetitive_task:))

    render_inline(ActivityLogComponent.new(activity_log:, current_user: user))
    assert_text activity_log.text
    assert_text activity_log.created_at.strftime('%Y-%m-%d %H:%M')
    assert_no_selector 'li.bg-yellow-50'
  end

  it '他のユーザーのアクティビティで初めての表示であればハイライトされる' do
    other_user = users(:member2_of_group1)
    user_group = other_user.group
    repetitive_task = repetitive_tasks(:without_logs)
    activity_log = ActivityLog.create!(user: other_user, user_group:, loggable: ActivityLogs::TaskDoneLog.new(repetitive_task:), created_at: Time.zone.now - 1.day)

    render_inline(ActivityLogComponent.new(activity_log:, current_user: user))
    assert_selector 'li.bg-yellow-50'
  end
end
