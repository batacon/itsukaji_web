# frozen_string_literal: true

class ActivityLog < ApplicationRecord
  belongs_to :user_group
  belongs_to :user

  # TODO: ActivityLogs::GroupMemberRemovedLog
  DELEGATED_TYPES = %w[
    ActivityLogs::TaskCreateLog
    ActivityLogs::TaskDeleteLog
    ActivityLogs::TaskDoneLog
    ActivityLogs::TaskUndoneLog
    ActivityLogs::TaskLogDateChangeLog
    ActivityLogs::GroupMemberAddedLog
  ].freeze

  delegated_type :loggable, dependent: :destroy, types: DELEGATED_TYPES
  delegate :emoji, to: :loggable
  delegate :text, to: :loggable

  scope :for_notification_of_group, ->(group) { where(user_group: group).order(created_at: :desc).limit(50) }
  scope :should_highlight_for, ->(user) { non_checked_by(user).acted_except(user) }
  scope :non_checked_by, ->(user) { where('created_at > ?', user.last_check_activity_logs_at) }
  scope :acted_except, ->(user) { where.not(user:) }

  def should_highlight_for?(target_user)
    created_at > target_user.last_check_activity_logs_at && user_id != target_user.id
  end
end
