# frozen_string_literal: true

class TaskCreateLog < ApplicationRecord
  include Loggable

  belongs_to :repetitive_task

  def text
    "#{activity_log.user.name}さんが#{repetitive_task.name}を作成しました"
  end
end
