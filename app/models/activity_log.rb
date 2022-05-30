# frozen_string_literal: true

class ActivityLog < ApplicationRecord
  belongs_to :user_group
  belongs_to :user

  delegated_type :loggable, dependent: :destroy, types: %w[ActivityLogs::TaskCreateLog ActivityLogs::TaskDeleteLog ActivityLogs::TaskDoneLog]
  delegate :text, to: :loggable

  scope :for_notification_of_group, ->(group) { where(user_group: group).limit(8) }
end
