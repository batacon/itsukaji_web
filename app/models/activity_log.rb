# frozen_string_literal: true

class ActivityLog < ApplicationRecord
  belongs_to :user_group
  belongs_to :user

  DELEGATED_TYPES = %w[
    ActivityLogs::TaskCreateLog
    ActivityLogs::TaskDeleteLog
    ActivityLogs::TaskDoneLog
  ].freeze
  delegated_type :loggable, dependent: :destroy, types: DELEGATED_TYPES
  delegate :text, to: :loggable

  scope :for_notification_of_group, ->(group) { where(user_group: group).order(created_at: :desc).limit(50) }
end
