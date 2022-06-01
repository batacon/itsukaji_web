# frozen_string_literal: true

module ActivityLogs
  class TaskDeleteLog < ApplicationRecord
    include Loggable

    validates :task_name, presence: true

    def text
      @text ||= "#{activity_log.user.name}さんが「#{task_name}」を削除しました。"
    end
  end
end
