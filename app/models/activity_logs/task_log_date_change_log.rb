# frozen_string_literal: true

module ActivityLogs
  class TaskLogDateChangeLog < ApplicationRecord
    include Loggable

    belongs_to :repetitive_task

    validates :from, presence: true
    validates :to, presence: true

    def text
      user_name = "#{activity_log.user.name}さん"
      @text ||= "⏰ #{bold(user_name)}が「#{bold(repetitive_task.name)}」のやった！ログを#{from}から#{to}に変更しました。"
    end
  end
end