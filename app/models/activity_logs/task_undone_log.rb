# frozen_string_literal: true

module ActivityLogs
  class TaskUndoneLog < ApplicationRecord
    include Loggable

    belongs_to :repetitive_task

    def text
      @text ||= "#{activity_log.user.name}さんが「#{repetitive_task.name}」を未完了に戻しました。"
    end
  end
end
