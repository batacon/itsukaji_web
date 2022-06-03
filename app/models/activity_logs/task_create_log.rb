# frozen_string_literal: true

module ActivityLogs
  class TaskCreateLog < ApplicationRecord
    include Loggable

    belongs_to :repetitive_task

    def text
      user_name = "#{activity_log.user.name}さん"
      @text ||= "✏️ #{bold(user_name)}が新タスク「#{bold(repetitive_task.name)}」を作成しました。"
    end
  end
end
