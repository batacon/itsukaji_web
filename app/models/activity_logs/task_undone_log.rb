# frozen_string_literal: true

module ActivityLogs
  class TaskUndoneLog < ApplicationRecord
    include Loggable

    belongs_to :repetitive_task

    def text
      user_name = "#{activity_log.user.name}さん"
      @text ||= "↪️ #{bold(user_name)}が「#{bold(repetitive_task.name)}」を未完了に戻しました。"
    end
  end
end
