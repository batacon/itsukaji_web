# frozen_string_literal: true

module ActivityLogs
  class TaskDeleteLog < ApplicationRecord
    include Loggable

    validates :task_name, presence: true

    def text
      user_name = "#{activity_log.user.name}さん"
      @text ||= "✂︎ #{bold(user_name)}が「#{bold(task_name)}」を削除しました。"
    end
  end
end
