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
  scope :should_highlight_for, ->(user) { not_checked_by(user).not_acted_by(user) }
  scope :not_checked_by, ->(user) { where('created_at > ?', user.last_check_activity_logs_at) }
  scope :not_acted_by, ->(user) { where.not(user:) }

  def should_highlight_for?(target_user)
    created_at > target_user.last_check_activity_logs_at && user_id != target_user.id
  end

  class << self
    def create_task_create_log(user, repetitive_task)
      user_group = user.group
      loggable = ::ActivityLogs::TaskCreateLog.new(repetitive_task:)
      create!(user_group:, user:, loggable:)
    end

    def create_task_delete_log(user, task_name)
      user_group = user.group
      loggable = ::ActivityLogs::TaskDeleteLog.new(task_name:)
      create!(user_group:, user:, loggable:)
    end

    def create_task_done_log(user, repetitive_task)
      user_group = user.group
      loggable = ::ActivityLogs::TaskDoneLog.new(repetitive_task:)
      create!(user_group:, user:, loggable:)
    end

    def create_task_log_date_change_log(user, repetitive_task, from:, to:)
      user_group = user.group
      loggable = ::ActivityLogs::TaskLogDateChangeLog.new(repetitive_task:, from:, to:)
      create!(user_group:, user:, loggable:)
    end

    def create_task_undone_log(user, repetitive_task)
      user_group = user.group
      loggable = ::ActivityLogs::TaskUndoneLog.new(repetitive_task:)
      create!(user_group:, user:, loggable:)
    end

    def create_group_member_added_log(user)
      user_group = user.group
      loggable = ::ActivityLogs::GroupMemberAddedLog.new
      create!(user_group:, user:, loggable:)
    end
  end
end
