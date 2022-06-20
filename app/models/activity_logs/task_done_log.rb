# frozen_string_literal: true

module ActivityLogs
  class TaskDoneLog < ApplicationRecord
    include Loggable

    belongs_to :repetitive_task

    def emoji
      '✅'
    end

    def text
      @text ||= "が「#{repetitive_task.name}」を完了しました！"
    end
  end
end
