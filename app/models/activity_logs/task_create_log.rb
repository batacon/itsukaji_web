# frozen_string_literal: true

module ActivityLogs
  class TaskCreateLog < ApplicationRecord
    include Loggable

    belongs_to :repetitive_task

    def emoji
      '✏️ '
    end

    def text
      @text ||= "が新タスク「#{repetitive_task.name}」を作成しました。"
    end
  end
end
