# frozen_string_literal: true

module ActivityLogs
  class TaskUndoneLog < ApplicationRecord
    include Loggable

    belongs_to :repetitive_task

    def emoji
      '↪️'
    end

    def text
      @text ||= "が「#{repetitive_task.name}」を未完了に戻しました。"
    end
  end
end
