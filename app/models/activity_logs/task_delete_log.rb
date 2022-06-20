# frozen_string_literal: true

module ActivityLogs
  class TaskDeleteLog < ApplicationRecord
    include Loggable

    validates :task_name, presence: true

    def emoji
      '✂︎'
    end

    def text
      @text ||= "が「#{task_name}」を削除しました。"
    end
  end
end
