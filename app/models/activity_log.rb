# frozen_string_literal: true

class ActivityLog < ApplicationRecord
  belongs_to :user_group
  belongs_to :user

  delegated_type :loggable, types: %w[TaskCreateLog TaskDoneLog], dependent: :destroy
  delegate :text, to: :loggable
end
